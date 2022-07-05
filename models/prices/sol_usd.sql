select *
from {{ source('prices', 'sol_usd_raw') }}
