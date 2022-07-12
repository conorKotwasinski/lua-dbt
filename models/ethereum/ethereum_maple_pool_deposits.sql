-- maple.pool_deposits
/*

    Each pool function call will create a total of 14 event-value records. We can use this knowledge
    to pivot the table out to show all event information for a given transaction.

    Events
    ------
    1. DepositDateUpdated:      Emits an event indicating a that a Liquidity Provider's effective deposit date has changed.
    2. Transfer:                Emitted when `value` tokens are moved from one account (`from`) to another (`to`). Note that `value` may be zero.
    3. PointsCorrectionUpdated: This event emits when an account's `pointsCorrection` is updated.First parameter is the address of some account.Second parameter is the new value of the account's `pointsCorrection`.
    4. LossesCorrectionUpdated: No description
    5. BalanceUpdated:          Emits an event indicating some Balance was updated.
    6. Cooldown:                Emits an event indicating a that the withdrawal cooldown for a Liquidity Provider of the Pool has updated.

    Event-values (in-order)
    -----------------------
    1.  DepositDateUpdated.liquidityProvider:     The address of a Liquidity Provider.
    2.  DepositDateUpdated.depositDate:           The new effective deposit date.
    3.  Transfer.from:                            From address
    4.  Transfer.to:                              To address
    5.  Transfer.value:                           Transfer value
    6.  PointsCorrectionUpdated.account:          Some account
    7.  PointsCorrectionUpdated.pointsCorrection: New value of the account's `pointsCorrection`
    8.  LossesCorrectionUpdated.account:          No description
    9.  LossesCorrectionUpdated.lossesCorrection: No description
    10. BalanceUpdated.liquidityProvider:         The address of a Liquidity Provider.
    11. BalanceUpdated.token:                     The address of the token for which the balance of `liquidityProvider` changed.
    12. BalanceUpdated.balance:                   The new balance for `liquidityProvider`.
    13. Cooldown.liquidityProvider:               The address of a Liquidity Provider.
    14. Cooldown.cooldown:                        The new withdrawal cooldown.

 */
-- pool deposit transactions
with pool_transactions as (
    select hash
    from ethereum.transactions_raw
    where to_address in (select address from seeds.maple_pools)
        and substr(input, 1, 10) = '0xb6b55f25' -- deposit function selector
),

-- pool deposit events
pool_events as (
    select
        block_number,
        transaction_hash,
        groupArray((concat(abi_name, '.', name), value)) as event
    from ethereum.events_raw
    where transaction_hash in (select hash from pool_transactions)
        and address in (select address from seeds.maple_pools)
    group by block_number, transaction_hash
)

select
    block_number,
    transaction_hash,
    toDateTime(toInt64(event[1].2))  as deposit_date_updated__deposit_date,
    lower(event[2].2)                as deposit_date_updated__liquidity_provider,
    lower(event[3].2)                as transfer__from,
    lower(event[4].2)                as transfer__to,
    toUInt256(event[5].2)            as transfer__value,
    lower(event[6].2)                as points_correction_updated__account,
    toInt256(event[7].2)             as points_correction_updated__points_correction,
    lower(event[8].2)                as losses_correction_updated__account,
    toInt256(event[9].2)             as losses_correction_updated__losses_correction,
    toUInt256(event[10].2)           as balance_updated__balance,
    lower(event[11].2)               as balance_updated__liquidity_provider,
    lower(event[12].2)               as balance_updated__token,
    toInt64(event[13].2)             as cooldown__cooldown,
    lower(event[14].2)               as cooldown__liquidity_provider
from pool_events
