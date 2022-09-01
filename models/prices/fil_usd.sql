select *
from {{ source('prices', 'fil_usd_raw') }}