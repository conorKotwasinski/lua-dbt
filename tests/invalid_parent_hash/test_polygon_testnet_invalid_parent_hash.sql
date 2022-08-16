with t as (
    select
        parent_hash as parent_hash,
        any(hash) over (order by number rows between 1 preceding and 1 preceding) as check_hash
    from {{ ref('polygon_testnet_blocks') }}
    where timestamp between (today() - 5) and date_sub(hour, 2, now())
)

select *
from t
where check_hash != ''
    and parent_hash != check_hash
