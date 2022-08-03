select
    address,
    tag,
    label,
    details
from {{ source('ethereum', 'tags_raw') }}
