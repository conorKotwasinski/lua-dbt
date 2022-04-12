
{{ config(
    materialized='view',
    
    ) 
}}
-- schema='ens'


-- ┌─────ct─┬─name──────────┐
-- │ 407544 │ owner         │
-- │ 454606 │ expires       │
-- │ 454606 │ label         │
-- │      1 │ newOwner      │
-- │ 454606 │ cost          │
-- │ 454606 │ name          │
-- │      1 │ previousOwner │
-- └────────┴───────────────┘

select 
"address",
"name_tag" as "tag"
from default.name_tags2_local