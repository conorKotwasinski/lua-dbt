{#
    Incremental materialization is used to avoid error that occurs on
    table materialization where dbt-clickhouse uses a rename-drop-rename
    table creation strategy. This does not work with `ReplicatedMergeTree`
    because of the replica name duplication.
#}

{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree('/clickhouse/tables/{database}/{table}', '{replica}')",
    order_by=["namespace", "contract_name", "contract_address"],
    unique_key=["namespace", "contract_name", "contract_address"],
    pre_hook="truncate table if exists {{ this }} on cluster 'lua-2'",
    inserts_only=true
) }}

with

-- D
degens as (
    -- Degens
    select
        'Degens' as namespace,
        'Degens' as contract_name,
        '0x8888888883585b9a8202db34d8b09d7252bfc61c' as contract_address
),

-- U
uniswapv2 as (
    -- Factory
    select
        'UniswapV2' as namespace,
        'Factory' as contract_name,
        '0x5c69bee701ef814a2b6a3edd4b1652cb9cc5aa6f' as address
    union all
    -- Pair
    select
        'UniswapV2' as namespace,
        'Pair' as contract_name,
        lower(evt.event_arg_value) as contract_address
    from {{ ref('ethereum_events') }} as evt
    where evt.contract_address = '0x5c69bee701ef814a2b6a3edd4b1652cb9cc5aa6f'
        and evt.event_name = 'PairCreated'
        and evt.event_arg_name = 'pair'
    union all
    -- Router01
    select
        'UniswapV2' as namespace,
        'Router01' as contract_name,
        '0xf164fc0ec4e93095b804a4795bbe1e041497b92a' as address
    union all
    -- Router02
    select
        'UniswapV2' as namespace,
        'Router02' as contract_name,
        '0x7a250d5630b4cf539739df2c5dacb4c659f2488d' as address
)

select * from degens
union all
select * from uniswapv2
