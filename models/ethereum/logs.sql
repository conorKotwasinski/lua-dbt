select
    block_number,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index,
    address,
    data,
    topic1,
    topic2,
    topic3,
    topic4
from {{ source('default', 'logs') }}
