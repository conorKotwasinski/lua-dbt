select *
from {{ source('prices', 'btc_usd_raw') }}
