
{{ config(materialized='view', alias='blocks', schema='polygon') }}

select 
"number", 
"hash", 
"timestamp", 
"size",
"transaction_count",
"transactions_root",
"miner",
"nonce",
"logs_bloom",
"state_root",
"difficulty",
"total_difficulty",
"parent_hash",
"sha3_uncles",
"receipts_root",
"gas_used",
"gas_limit",
"base_fee_per_gas",
"extra_data"
from "polygon"."blocks_raw" as b