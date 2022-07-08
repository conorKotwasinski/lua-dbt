select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    from_address,
    to_address,
    value,
    input,
    output,
    trace_type,
    call_type,
    reward_type,
    gas,
    gas_used,
    subtraces,
    trace_address,
    error,
    status,
    trace_id
from {{ source('ethereum', 'traces_raw') }}
