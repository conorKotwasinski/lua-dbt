{{ config(materialized='view') }}

select 
block_number, 
transaction_index,
value,
block_timestamp
from transactions

