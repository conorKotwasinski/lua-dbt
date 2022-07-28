select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index,
    address,
    data,
    topic1,
    topics[2] as topic2,
    topics[3] as topic3,
    topics[4] as topic4
from {{ source('avalanche', 'logs_raw') }}
