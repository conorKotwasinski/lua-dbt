select
    block_hash,
    block_number,
    transaction_hash,
    transaction_index,
    log_index,
    -- {% for payment_method in ['owner', 'expires', 'label', 'cost', 'name'] %}
    -- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
    -- {% endfor %}
    max(case when e.name = 'name' then e.value end) as domain,
    max(case when e.name = 'expires' then toDateTime(e.value) end) as expires,
    max(case when e.name = 'owner' then e.value end) as owner,
    max(case when e.name = 'cost' then e.value end) as cost
    -- max(case when e.name = 'label' then e.value end) as label
from {{ ref('ethereum_events') }} as e
where e.abi_name = 'NameRegistered'
    and e.address = '0x283af0b28c62c092c9727f1ee09c02ca627eb7f5'
group by 
    block_hash,
    block_number,
    transaction_hash,
    transaction_index,
    log_index
