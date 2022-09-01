select *
from {{ source('prices', 'grt_usd_raw') }}