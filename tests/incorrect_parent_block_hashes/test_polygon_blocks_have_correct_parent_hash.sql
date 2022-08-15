{# For context, see: https://github.com/luabase/lua-dbt/issues/69 #}
with t as (
    select
        number,
        hash,
        any(number) over (order by number rows between 1 following and 1 following) as check_number,
        any(parent_hash) over (order by number rows between 1 following and 1 following) as check_hash
    from {{ source('polygon', 'blocks_raw') }}
),

missing_blocks as (
    select number, hash, check_number, check_number - 1 as missing_block, check_hash
    from t
    where hash != check_hash
        and check_number != 0
    order by missing_block
)

select *
from {{ source('polygon', 'blocks_raw') }}
where toInt64(number) in (select missing_block from missing_blocks)
