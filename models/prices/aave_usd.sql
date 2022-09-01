select *
from {{ source('prices', 'aave_usd_raw') }}