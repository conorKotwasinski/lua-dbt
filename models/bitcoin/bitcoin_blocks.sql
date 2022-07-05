select *
from {{ source('bitcoin', 'blocks_raw') }}
