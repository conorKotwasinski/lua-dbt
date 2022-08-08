select
    address,
    tags[1] as tag, 
    labels[1] as label,
    tags as tag_details,
    labels as label_details
from {{ source('ethereum', 'tags_raw') }}
