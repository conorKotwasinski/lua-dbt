-- Initial filter for NFTs,
-- since tags currently doesn't map NFTs cleanly
with nfts as (
    select *
    from {{ ref('ethereum_events') }}
    where address in (
        '0xed5af388653567af2f388e6224dc7c4b3241c544',
        '0x8a90cab2b38dba80c64b7734e58ee1db38b8992e',
        '0x7bd29408f11d2bfc23c34f18275bbf23bb716bc7',
        '0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d',
        '0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb'
    )
),

transfers_raw as (
    select
        transaction_hash,
        block_number,
        address as nft_contract_address,
        log_index,
        groupArray((value)) as outputs
    from nfts
    -- Majority of NFTs except cryptopunks use 'Transfer' transaction type
    where (abi_name = 'Transfer' and address != '0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb')
        or abi_name = 'transferPunk'
    group by
        transaction_hash,
        nft_contract_address,
        block_number,
        log_index
),

transfers as (
    select
        transaction_hash,
        log_index,
        nft_contract_address,
        block_number,
        toString(outputs[1]) as from_address,
        toString(outputs[2]) as to_address,
        outputs[3] as nft_token_id,
        if(
            -- NFTs from null address == mint
            from_address='0x0000000000000000000000000000000000000000',
            'Mint',
            'Transfer'
        ) as event_type
    from transfers_raw
),

marketplace_events as (
    select distinct
        e.transaction_hash,
        t.tag,
        e.log_index,
        e.abi_name,
        e.name,
        e.value as cost
    from {{ ref('ethereum_events') }} as e
        left join {{ ref('ethereum_tags') }} as t on t.address = e.address
    -- limit to known exchanges
    where e.address in (
            '0x7be8076f4ea4a4ad08075c2508e481d6c946d12b', -- Opensea Wyvern Exchange v1
            '0x7f268357a8c2552623316e2562d90e642bb538e5' -- Opensea Wyvern Exchange v2
        )
        and abi_name = 'OrdersMatched'
        and e.name = 'price'
)

select 
    t.*,
    m.tag as marketplace_name,
    m.cost
from transfers as t
    left join marketplace_events as m on m.transaction_hash = t.transaction_hash
