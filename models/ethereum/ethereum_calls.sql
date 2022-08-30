select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    transaction_index,
    contract_address,
    contract_name,
    caller_address,
    input,
    call_status as call_success,
    function_name,
    function_input_name,
    function_input_value,
    function_input_type
from {{ source('ethereum', 'calls_raw') }}
