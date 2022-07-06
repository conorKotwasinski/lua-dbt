select
    block_number,
    block_timestamp,
    block_hash,
    address,
    symbol,
    name,
    decimals,
    total_supply
from {{ source('ethereum', 'token_raw') }}
