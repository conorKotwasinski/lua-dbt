select
    number,
    hash,
    timestamp,
    size,
    transaction_count,
    transactions_root,
    miner,
    nonce,
    {# Removed `uncles` in migration to schema v2 #}
    {# Removed `mix_hash` in migration to schema v2 #}
    logs_bloom,
    state_root,
    difficulty,
    total_difficulty,
    parent_hash,
    sha3_uncles,
    receipts_root,
    gas_used,
    gas_limit,
    base_fee_per_gas,
    extra_data
from {{ source('ethereum', 'blocks_raw') }}
