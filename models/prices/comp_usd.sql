select *
from {{ source('prices', 'comp_usd_raw') }}