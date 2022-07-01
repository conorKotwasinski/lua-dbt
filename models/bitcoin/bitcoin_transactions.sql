select
    hash,
    size,
    virtual_size,
    version,
    lock_time,
    block_number,
    block_hash,
    block_timestamp,
    is_coinbase,
    transaction_index,
    input_count,
    output_count,
    input_value,
    output_value,
    fee
from {{ source('bitcoin', 'transactions_raw') }}
