
{{ config(materialized='view') }}

select 
"block_number",
"block_hash",
"transaction_hash",
"transaction_index",
"log_index",
"address",
"abi_name",
"name",
"type",
"value"
from "default"."events" as b