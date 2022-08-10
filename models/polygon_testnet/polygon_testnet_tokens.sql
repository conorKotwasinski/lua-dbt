select
    block_number,
    block_hash,
    block_timestamp,
    address,
    symbol,
    name,
    decimals,
    total_supply
from {{ source('polygon_testnet', 'tokens_raw') }}
