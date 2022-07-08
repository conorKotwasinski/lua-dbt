select
    block_number,
    block_hash,
    block_timestamp,
    address,
    symbol,
    name,
    decimals,
    total_supply
from {{ source('polygon', 'tokens_raw') }}
