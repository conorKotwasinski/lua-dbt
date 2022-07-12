{{ config(
    materialized='incremental',
    engine='MergeTree()',
    order_by=['block_number'],
    partition_by=['toYYYYMM(block_timestamp)', 'ignore(block_number)'],
    on_schema_change='fail',
    inserts_only=true
) }}

with agg_balances as (
    select
        block_number,
        block_hash,
        block_timestamp,
        address,
        toFloat64(sum(value)) * 1e-18 as balance
    from {{ ref('intm__ethereum_balance_deltas') }}
    {% if is_incremental() %}
    where block_number > (select max(block_number) from {{ this }})
    {% endif %}
    group by block_number, block_hash, block_timestamp, address
)

select
    block_number,
    block_hash,
    block_timestamp,
    address,
    sum(balance) over (partition by address order by block_number) as balance
from agg_balances
