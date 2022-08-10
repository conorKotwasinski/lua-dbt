select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    log_index,
    token_address,
    from_address,
    to_address,
    value
from {{ source('polygon_testnet', 'token_transfers_raw') }}
