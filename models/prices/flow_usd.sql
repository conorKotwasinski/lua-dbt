select *
from {{ source('prices', 'flow_usd_raw') }}