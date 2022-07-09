select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index,
    address,
    data,
    topics[1] as topic1,
    topics[2] as topic2,
    topics[3] as topic3,
    topics[4] as topic4
from {{ source('ethereum', 'logs_raw') }}
