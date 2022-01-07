
{{ config(materialized='view') }}

-- number:            8894460
-- hash:              0x23ac071475225c4c6f5d74792c071598556b8b96b5883c1cefd03d19bf2452ea
-- timestamp:         2019-11-08 05:42:43
-- size:              4495
-- miner:             0x829BD824B016326A401d083B33D092293333A830
-- nonce:             0xba4995502b6f243e
-- uncles:            []
-- mix_hash:          0xb3ef5be725586727ec449d5b033114496e170c7c6b57ab8dcd68ec0e1661668d
-- logs_bloom:        0xee0101b6171022450ea1562fa467354047e1202b57501081c46a998cc485849511d001db50a0fc7610600d8510cc0dc1099a158109dda48b4389c6cc8e549482005173cb8919060d4d2636fe423b05a4465a631226a91bc6705b4b8f7132ef68ab44106c26396821b016a00075899d3279ec21381104576c3d0d235242079010620541501b210b7486544e77c5d6279a21e42d8a50d42131d16d74c12e1a91c985128c0b0c5b9028c52e1c903426f0f51543958c4f51c5458263902086911dd32184880e973c32a920d9808b4ba420690c81b802c18d805f6f2ee0bc4199e17481641e32482a59b7e22140e0601ad8400004895958c938618842525841723b49
-- state_root:        0x9b8db61e485a4b8b3cc44d82e79eb965253eabc4a3b5e063ec07622b7bbd737c
-- difficulty:        2427165342845424
-- total_difficulty:  12752515314902950785661
-- parent_hash:       0x4f60c12826076a44a6efcf36ed0d8aa4f27308fe115cb195aa7020bb01e6163a
-- sha3_uncles:       0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347
-- receipts_root:     0xe27634a3647f3310e8d205af1c5591be11ca188774591c0851c4f76c9da56af0
-- transaction_count: 20
-- transactions_root: 0x869ce2181bb1adbc7f60c984f99318819325be75a607dcf5322790ac434d565e
-- gas_used:          5795381
-- gas_limit:         9989938
-- base_fee_per_gas:  0
-- extra_data:        0x7070796520e4b883e5bda9e7a59ee4bb99e9b1bc

select 
"number", 
"hash", 
"timestamp", 
"size",
"transaction_count",
"transactions_root",
"miner",
"nonce",
"uncles",
"mix_hash",
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
from blocks as b