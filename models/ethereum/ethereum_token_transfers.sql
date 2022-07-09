select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    log_index,
    token_address,
    from_address,
    to_address,
    value
from {{ source('ethereum', 'token_transfers_raw') }}
