select *
from {{ ref('events') }}
where address in (
    select distinct lower(value)
    from {{ ref('events') }}
    where address = '0x2cd79f7f8b38b9c0d80ea6b230441841a31537ec'
        and abi_name = 'PoolCreated'
        and name = 'pool'
)
