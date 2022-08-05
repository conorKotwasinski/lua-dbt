select
    address,
    tag, 
    labels[1] as label,
    labels as details
from {{ source('ethereum', 'tags_raw') }}
