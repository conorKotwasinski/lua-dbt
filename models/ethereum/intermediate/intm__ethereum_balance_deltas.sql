{{ config(
    materialized='incremental',
    engine='MergeTree()',
    order_by=['block_number'],
    partition_by=['toYYYYMM(block_timestamp)', 'ignore(block_number)'],
    on_schema_change='fail',
    inserts_only=true
) }}

with block_parts as (
    select
        toYYYYMM(timestamp) as part,
        max(number) as block_number
    from {{ ref('ethereum_blocks') }}
    where number > (select max(block_number) from {{ this }})
    group by part
    order by block_number
    limit 1
),

_traces as (
    select
        block_number,
        block_hash,
        block_timestamp,
        to_address,
        from_address,
        toInt256(value) as value
    from {{ ref('ethereum_traces') }}
    where 1 = 1
        {% if is_incremental() %}
        and block_number > (select max(block_number) from {{ this }})
        and block_number <= (select block_number from block_parts)
        {% else %}
        and toYYYYMM(block_timestamp) = 197001
        {% endif %}
        and status = 1
        and (call_type not in ('delegatecall', 'callcode', 'staticcall') or call_type is null)
    order by block_number, block_hash, trace_id
),

_transactions as (
    select
        t.block_number,
        t.block_hash,
        t.block_timestamp,
        t.from_address,
        b.miner as to_address,
        toInt256(t.gas * t.gas_price) as value
    from {{ ref('ethereum_transactions') }} as t
        left join {{ ref('ethereum_blocks') }} as b on t.block_number = b.number
    where toYYYYMM(block_timestamp) = toYYYYMM(now())
        {% if is_incremental() %}
        and block_number > (select max(block_number) from {{ this }})
        and block_number <= (select block_number from block_parts)
        {% else %}
        and toYYYYMM(block_timestamp) = 197001
        {% endif %}
),

debits as (
    select
        block_number,
        block_hash,
        block_timestamp,
        to_address as address,
        value
    from _traces
    where to_address is not null

    union all

    select
        block_number,
        block_hash,
        block_timestamp,
        to_address as address,
        value
    from _transactions
),

credits as (
    select
        block_number,
        block_hash,
        block_timestamp,
        from_address as address,
        -1 * value as value
    from _traces
    where from_address is not null

    union all

    select
        block_number,
        block_hash,
        block_timestamp,
        from_address as address,
        -1 * value as value
    from _transactions
)

select * from debits
union all
select * from credits
