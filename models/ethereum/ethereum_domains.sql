select
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index,
    max(case when event_arg_name = 'name' then event_arg_value end) as domain,
    max(case when event_arg_name = 'expires' then toDateTime(event_arg_value) end) as expires,
    max(case when event_arg_name = 'owner' then lower(event_arg_value) end) as owner,
    toUInt256(max(case when event_arg_name = 'cost' then event_arg_value end)) as cost
from {{ ref('ethereum_events') }} as e
where event_name = 'NameRegistered'
    and contract_address = '0x283af0b28c62c092c9727f1ee09c02ca627eb7f5'
group by 
    block_number,
    block_timestamp,
    block_hash,
    transaction_hash,
    transaction_index,
    log_index
