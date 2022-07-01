select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    input_index,
    spent_transaction_hash,
    spent_output_index,
    script_asm,
    script_hex,
    sequence,
    required_signatures,
    type,
    addresses,
    value
from {{ source('bitcoin', 'transaction_inputs_raw') }}
