{{ config(materialized='view', alias='transaction_outputs', schema='bitcoin') }}


-- SELECT *
-- FROM transaction_outputs_raw
-- LIMIT 2
-- FORMAT Vertical

-- Query id: 8819037d-03b9-4bc5-82b9-b8397e0d2aad

-- Row 1:
-- ──────
-- output_index:        0
-- script_asm:          OP_RETURN f09f98bc2053616372696669636520746f204c61756461212028746f7069633d3532383239313129
-- script_hex:          6a28f09f98bc2053616372696669636520746f204c61756461212028746f7069633d3532383239313129
-- required_signatures: 1
-- type:                nonstandard
-- addresses:           ['nonstandard5c38a55fd55bbe94c0821698ca26f9a8e7487f04']
-- value:               1
-- transaction_hash:    000000000fdf0c619cd8e0d512c7e2c0da5a5808e60f12f1e0d01522d2986a51
-- block_number:        674611
-- block_hash:          00000000000000000006dcd3ec1837be312461e45e97e2f15b2a1a3d7fa4f294
-- block_timestamp:     2021-03-14 16:51:24


select 
"block_number",
"block_hash",
"block_timestamp",
"transaction_hash",
"output_index",
"script_asm",
"script_hex",
"required_signatures",
"type",
"addresses",
"value"
from 
"bitcoin"."transaction_outputs_raw" as t 