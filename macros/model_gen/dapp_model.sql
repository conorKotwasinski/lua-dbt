{%- macro dapp_model(
    type,
    namespace,
    contract_name,
    abi_name,
    inputs,
    alias_map={}
) %}
{%- set base_fields = [
    'block_number',
    'block_hash',
    'block_timestamp',
    'transaction_hash',
    'transaction_index',
    'contract_address'
] -%}
{%- if type == 'call' -%}
    {%- set fields = base_fields + ['caller_address', 'call_success'] -%}
    {%- set reference = 'ethereum_calls' -%}
    {%- set name_col = 'function_input_name' -%}
    {%- set value_col = 'function_input_value' -%}
{%- elif type == 'event' -%}
    {%- set fields = base_fields + ['log_index'] -%}
    {%- set reference = 'ethereum_events' -%}
    {%- set name_col = 'event_arg_name' -%}
    {%- set value_col = 'event_arg_value' -%}
{%- endif -%}

select
    {{ fields | join(',') }}{{ ',' if inputs else '' }}
    {% for input in inputs %}
    max(case when {{ name_col }} = '{{ input }}' then {{ value_col }} end) as {{ alias_map[input]|default(input) }}{{ ", " if not loop.last else "" }}
    {% endfor %}
from {{ ref(reference) }}
where contract_address in (
    select contract_address
    from {{ ref('eth_namespaces') }}
    where namespace = '{{ namespace }}'
        and contract_name = '{{ contract_name }}'
)
    and {% if type == 'call' %} function_name {% else %} event_name {% endif %} = '{{ abi_name }}'
{% if is_incremental() %}
    and block_number > (select max(block_number) from {{ this }})
{% endif %}
group by
    {{ fields | join(',') }}
{% endmacro -%}
