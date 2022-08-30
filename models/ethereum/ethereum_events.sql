select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    transaction_index,
    log_index,
    contract_address,
    contract_name,
    event_name,
    event_arg_name,
    event_arg_value,
    event_arg_type
from {{ source('ethereum', 'events_raw') }}
