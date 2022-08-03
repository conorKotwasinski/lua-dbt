select
    address,
    tag,
    label
from {{ source('ethereum', 'tags_raw_v2') }}