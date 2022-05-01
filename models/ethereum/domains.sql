
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
"block_hash",
"block_number",
"transaction_hash",
"transaction_index",
"log_index",
-- {% for payment_method in ["owner", "expires", "label", "cost", "name"] %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
-- {% endfor %}
max(case when e."name" = 'name' then e."value" end) as "domain",
max(case when e."name" = 'expires' then toDateTime(e."value") end) as "expires",
max(case when e."name" = 'owner' then e."value" end) as "owner",
max(case when e."name" = 'cost' then e."value" end) as "cost"
-- max(case when e."name" = 'label' then e."value" end) as "label"
from {{ ref('events') }} as e
where e.abi_name = 'NameRegistered'
and e."address" = lower('0x283Af0B28c62C092C9727F1Ee09c02CA627EB7F5')
group by 
"block_hash",
"block_number",
"transaction_hash",
"transaction_index",
"log_index"