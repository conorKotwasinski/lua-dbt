{{ config(materialized='view') }}

-- hash:                     0xb4a76859e71d2e741d1d90238c6b10e09bac273bbb9d6d48c802b9b76389d17c
-- nonce:                    45
-- block_hash:               
-- block_number:             12786459
-- transaction_index:        0
-- from_address:             0xdC939279623B88b23603E7eAD1Fd9C9De4c6FE7F
-- to_address:               0xdAC17F958D2ee523a2206206994597C13D831ec7
-- value:                    0
-- gas:                      100000
-- gas_price:                150000000000
-- input:                    0xa9059cbb00000000000000000000000054afa4ccd2a08202ea68627a36b3c4bc24672317000000000000000000000000000000000000000000000000000000004f1af618
-- block_timestamp:          1625744071
-- max_fee_per_gas:          0
-- max_priority_fee_per_gas: 0
-- transaction_type:         0

select 
"block_number", 
"transaction_index",
"hash",
"nonce",
"from_address",
"to_address",
"value",
"gas",
"gas_price",
"input",
"block_timestamp",
"max_fee_per_gas",
"max_priority_fee_per_gas",
"transaction_type"
from "transactions"