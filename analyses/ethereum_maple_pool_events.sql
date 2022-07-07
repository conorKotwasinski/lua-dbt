{# https://maplefinance.gitbook.io/maple/smart-contracts/pools/pool#events #}
select *
from {{ ref('events') }}
where address in (
    select distinct lower(value)
    from {{ ref('events') }}
    where address = '{{ var('maple_pool_factory_address') }}'
        and abi_name = 'PoolCreated'
        and name = 'pool'
)
