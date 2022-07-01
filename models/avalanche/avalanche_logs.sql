select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index,
    address,
    data,
    topics
from {{ source('avalanche', 'logs_raw') }}
