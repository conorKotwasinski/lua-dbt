{{ config(materialized='view', alias='traces', schema='polygon') }}

-- Row 1:
-- ──────
-- log_index:         204
-- transaction_hash:  0x00005bf95025dcf0831bd374eb18c3811fcac80ca3531582bc77ea1ff75e8adb
-- transaction_index: 55
-- address:           0xdf9b4b57865b403e08c85568442f95c26b7896b0
-- data:              0x0000000000000000000000000000000000000000000000000c3663566a580000
-- topics:            ['0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef','0x0000000000000000000000000000000000000000000000000000000000000000','0x000000000000000000000000d5b9469ee856f4ca48e1985057d9389c7c655c25']
-- block_number:      23850127
-- block_timestamp:   2022-01-18 02:52:56
-- block_hash:        0x575ec400e561e97f4f00f2107c568c442da55c1e9f942fab70bfedbd9e5e343e

select 
"block_number", 
"block_hash",
"block_timestamp",
"transaction_hash",
"transaction_index",
"to_address",
"from_address",
"value",
"input",
"trace_type",
"trace_id",
"call_type",
"reward_type",
"gas",
"gas_used",
"subtraces",
"trace_address",
"error",
"status"
from "polygon"."traces_raw"