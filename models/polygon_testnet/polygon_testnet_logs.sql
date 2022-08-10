select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    transaction_index,
    log_index,
    address,
    data,
    topics[1] as topic1,
    topics[2] as topic2,
    topics[3] as topic3,
    topics[4] as topic4
from {{ source('polygon_testnet', 'logs_raw') }}
