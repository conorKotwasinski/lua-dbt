select
    address,
    name_tag as tag,
    label as label
from {{ source('default', 'name_tags2_local') }}
