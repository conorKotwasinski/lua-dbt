select
    transaction_hash,
    log_index,
    count(1) as count
from {{ source('polygon', 'logs_raw') }}
where block_timestamp > (today() - 30)
group by transaction_hash, log_index
having count > 1
