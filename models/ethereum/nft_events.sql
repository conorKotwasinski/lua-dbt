{{ config(materialized='view') }}
-- transaction_hash:         0xb4a76859e71d2e741d1d90238c6b10e09bac273bbb9d6d48c802b9b76389d17c
-- log_index:                51
-- nft_contract_address:     0x8a90cab2b38dba80c64b7734e58ee1db38b8992e               
-- block_number:             14693081
-- from_address:             0x5a6bb42a124034b07db4ab5753120dfff68db7b7
-- to_address:               0x8ad52c3ab4233341f7a5b25dd0ebc4dcc26c53ee
-- nft_token_id:             6187
-- event_type:               Transfer
-- exchange_name:            Opensea
-- price:                    260000000000000000


with 
-- Initial filter for NFTs, 
-- since tags currently doesn't map NFTs cleanly
"nfts" as (
select * from "ethereum"."events" 
where address in ('0xed5af388653567af2f388e6224dc7c4b3241c544'
    ,'0x8a90cab2b38dba80c64b7734e58ee1db38b8992e'
    ,'0x7bd29408f11d2bfc23c34f18275bbf23bb716bc7'
    ,'0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d'
    ,'0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb'
    )
),

"transfers_raw" as (
SELECT
    "transaction_hash"
    ,"block_number"
    ,"address" as "nft_contract_address"
    ,"log_index"
    ,groupArray(("value")) as "outputs"
FROM nfts
WHERE true 
    -- Majority of NFTs except cryptopunks use 'Transfer' transaction type
    and ("abi_name" = 'Transfer' and address != '0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb')
    -- unique criteria for punks 
    OR "abi_name" = 'transferPunk'
GROUP BY "transaction_hash", "nft_contract_address", "block_number", "log_index"

),

"transfers" as (
select
    "transaction_hash" 
    ,"log_index" 
    ,"nft_contract_address"
    ,"block_number"
    ,toString("outputs"[1]) as "from_address"
    ,toString("outputs"[2]) as "to_address" 
    ,"outputs"[3] as "nft_token_id" 
    ,if( 
        -- NFTs from null address == mint
        "from_address"='0x0000000000000000000000000000000000000000'
        ,'Mint'
        ,'Transfer'
    ) as "event_type"
from "transfers_raw"
),

"marketplace_events" as (
select 
    distinct 
    e."transaction_hash"
    ,t."tag" 
    ,e."log_index" 
    ,e."abi_name" 
    ,e."name" 
    ,e."value" as "cost" 
from "ethereum"."events" e
    left join "ethereum"."tags" t on t."address" = e."address"
where true 
    -- limit to known exchanges
    and e."address" in (
        '0x7be8076f4ea4a4ad08075c2508e481d6c946d12b' -- Opensea Wyvern Exchange v1
        ,'0x7f268357a8c2552623316e2562d90e642bb538e5' -- Opensea Wyvern Exchange v2
        )
    and "abi_name" = 'OrdersMatched'
    and e."name" = 'price'
)

select 
    t.* 
    ,m."tag" as "marketplace_name"
    ,m."cost"
from "transfers" t
    left join "marketplace_events" m on m."transaction_hash" = t."transaction_hash"


