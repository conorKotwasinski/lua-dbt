{{ config(materialized='view', alias='transactions_test', schema='bitcoin_test') }}


-- lua-2 :) select * from transactions_raw limit 2 format Vertical

-- SELECT *
-- FROM transactions_raw
-- LIMIT 2
-- FORMAT Vertical

-- Query id: e221b39c-9bcd-4930-a0a5-6f7d2b5fa541

-- Row 1:
-- ──────
-- hash:              4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b
-- size:              204
-- virtual_size:      204
-- version:           1
-- lock_time:         0
-- block_number:      0
-- block_hash:        000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f
-- block_timestamp:   2009-01-03 18:15:05
-- is_coinbase:       1
-- transaction_index: ᴺᵁᴸᴸ
-- input_count:       0
-- output_count:      1
-- input_value:       0
-- output_value:      5000000000
-- fee:               0

select 
"hash",
"size",
"virtual_size",
"version",
"lock_time",
"block_number",
"block_hash",
"block_timestamp",
"is_coinbase",
"transaction_index",
"input_count",
"output_count",
"input_value",
"output_value",
"fee"
from 
"bitcoin"."transactions_raw" as t 
-- left join
-- "default"."receipts" as r on t."hash" = r."transaction_hash"
