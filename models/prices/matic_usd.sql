select *
from {{ source('prices', 'polygon_usd_raw') }}
