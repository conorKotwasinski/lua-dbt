select *
from {{ source('prices', 'eth_usd_raw') }}
