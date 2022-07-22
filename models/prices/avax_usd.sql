select *
from {{ source('prices', 'avax_usd_raw') }}
