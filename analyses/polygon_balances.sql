with filtered_traces as (
    select
        to_address,
        from_address,
        value
    from {{ ref('polygon_traces') }}
    where status = 1
        and (call_type not in ('delegatecall', 'callcode', 'staticcall', '') or call_type is null)
),

debits as (
    select
        to_address as address,
        value
    from filtered_traces
    where to_address is not null
),

credits as (
    select
        from_address as address,
        -1 * value as value
    from filtered_traces
    where from_address is not null
),

tx_fees_debits as (
    select
        block.timestamp as block_timestamp,
        block.number as block_number,
        block.miner as address,
        sum(tx.gas * tx.gas_price) as value
    from {{ ref('polygon_transactions') }} as tx
        inner join {{ ref('polygon_blocks') }} as block on tx.block_number = block.number
    group by
        block.timestamp,
        block.number,
        block.miner
),

tx_fees_credits as (
    select
        block_timestamp,
        block_number,
        from_address as address,
        -1 * (gas * gas_price) as value
    from {{ ref('polygon_transactions') }}
),

double_entry_ledger as (
    select address, toInt256(value) as value from credits
    union all
    select address, toInt256(value) as value from debits
    union all
    select address, toInt256(value) as value from tx_fees_debits
    union all
    select address, toInt256(value) as value from tx_fees_credits
)

select
    address,
    sum(value) as balance
from double_entry_ledger
group by address
order by balance desc
