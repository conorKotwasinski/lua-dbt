select
    block_number,
    block_hash,
    transaction_index,
    hash,
    nonce,
    from_address,
    to_address,
    value,
    gas,
    gas_price,
    input,
    block_timestamp,
    -- r.gas_used,
    max_fee_per_gas,
    max_priority_fee_per_gas,
    transaction_type
    -- r.status
from {{ source('polygon', 'transactions_raw') }}
