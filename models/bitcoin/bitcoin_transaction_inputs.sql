{{ config(materialized='view') }}


-- SELECT *
-- FROM transaction_inputs_raw
-- LIMIT 2
-- FORMAT Vertical

-- Query id: 92970be8-6d49-47cd-a156-c101f8ba93e1

-- Connecting to database bitcoin at lua-2.luabase.altinity.cloud:9440 as user admin.
-- Connected to ClickHouse server version 22.3.3 revision 54455.

-- ClickHouse client version is older than ClickHouse server. It may lack support for new features.

-- Row 1:
-- ──────
-- input_index:            0
-- spent_transaction_hash: e0721ca713e39e0b47529d9ec798795eeffc1692f279482eb299bcb74e28fded
-- spent_output_index:     19
-- script_asm:             
-- script_hex:             
-- sequence:               4294967293
-- required_signatures:    1
-- type:                   witness_v0_keyhash
-- addresses:              ['bc1qy8ewyqq4hxh7gnznapvm0uwq9m09ntd2mmma94']
-- value:                  21125
-- transaction_hash:       00000160cec9751e8b88ea591fed96d42eb95a796053d53a12c1880f5ede2faa
-- block_number:           729467
-- block_hash:             00000000000000000004fba8c0cbcc4eb8ad0fab6765e3fa5c480b4bc1a95e08
-- block_timestamp:        2022-03-28 23:18:28

select 
"block_number",
"block_hash",
"block_timestamp",
"transaction_hash",
"input_index",
"spent_transaction_hash",
"spent_output_index",
"script_asm",
"script_hex",
"sequence",
"required_signatures",
"type",
"addresses",
"value"
from 
"bitcoin"."transaction_inputs_raw" as t 
-- left join
-- "default"."receipts" as r on t."hash" = r."transaction_hash"