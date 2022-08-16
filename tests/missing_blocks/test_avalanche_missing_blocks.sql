with t as (
    select
        number as block_number,
        any(number) over (order by number rows between 1 preceding and 1 preceding) as parent_block_number
    from {{ ref('avalanche_blocks') }}
    where timestamp between (today() - 5) and date_sub(hour, 2, now())
)

select
    block_number,
    parent_block_number
from t
where parent_block_number != 0
    and block_number != parent_block_number + 1
