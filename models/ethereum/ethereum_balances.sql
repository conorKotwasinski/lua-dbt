with ranked as (
    select
        address,
        balance,
        row_number() over (partition by address order by block_number desc) as n_rank
    from {{ ref('ethereum_historical_balances') }}
)

select
    address,
    balance
from ranked where n_rank = 1
