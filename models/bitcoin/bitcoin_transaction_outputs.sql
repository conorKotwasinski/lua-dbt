select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    output_index,
    script_asm,
    script_hex,
    required_signatures,
    type,
    addresses,
    value
from {{ source('bitcoin', 'transaction_outputs_raw') }}
