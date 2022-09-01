select *
from {{ source('prices', 'uni_usd_raw') }}