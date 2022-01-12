{{ config(materialized='view') }}

-- Row 1:
-- ──────
-- block_hash:        0x688484f241251654f382bdd6343f174e38eddd633336a15b2154af81a8c1ac10
-- block_number:      13000002
-- address:           0x20E95253e54490D8d30ea41574b24F741ee70201
-- data:              0x000000000000000000000000000000000000000000000000000011e66a4d3ee400000000000000000000000000000000000000000000014e8c525a6f30d4e21a
-- topic1:            0x1c411e9a96e071241c2f21f7726b17ae89e3cab4c78be50e062b03a9fffbbad1
-- topic2:            
-- topic3:            
-- topic4:            
-- log_index:         129
-- transaction_hash:  0x0b5de661234551626541c9d9fd2165805df3d661b0824bf4a11fe61c091d7927
-- transaction_index: 104

select 
"block_number", 
"block_hash",
"transaction_hash",
"transaction_index",
"log_index",
"address",
"data",
"topic1",
"topic2",
"topic3",
"topic4"
from "default"."logs"