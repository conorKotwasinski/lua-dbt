select
    block_number,
    block_timestamp,
    block_hash,
    hash,
    nonce,
    transaction_index,
    from_address,
    to_address,
    value,
    gas,
    gas_price,
    input,
    receipt_cumulative_gas_used,
    receipt_gas_used,
    receipt_contract_address,
    receipt_root,
    receipt_status,
    max_fee_per_gas,
    max_priority_fee_per_gas,
    transaction_type,
    receipt_effective_gas_price
from {{ source('avalanche', 'transactions_raw') }}
