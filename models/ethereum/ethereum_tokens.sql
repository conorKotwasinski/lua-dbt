with tokens as (
    select
        block_number,
        block_timestamp,
        block_hash,
        address,
        symbol,
        name,
        decimals,
        total_supply,
        row_number() over (partition by address order by block_timestamp desc) as n_rank
    from {{ source('ethereum', 'tokens_raw') }}
)

select
    block_number,
    block_timestamp,
    block_hash,
    address,
    symbol,
    name,
    decimals,
    total_supply
from tokens
where n_rank = 1
