select
    transaction_hash,
    trace_id,
    count(1) as count
from {{ source('polygon', 'traces_raw') }}
where block_timestamp > (today() - 15)
group by transaction_hash, trace_id
having count > 1
