select *
from {{ source('prices', 'axs_usd_raw') }}