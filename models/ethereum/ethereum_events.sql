select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index,
    address,
    contract_name,
    function_name,
    event_name,
    event_arg_index,
    event_arg_name,
    event_arg_value,
    event_arg_type
from {{ source('ethereum', 'events_raw') }}
