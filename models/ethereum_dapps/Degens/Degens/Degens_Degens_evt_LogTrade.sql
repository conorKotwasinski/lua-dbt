{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "event" %}
{% set namespace = "Degens" %}
{% set contract_name = "Degens" %}
{% set abi_name = "LogTrade" %}
{% set abi_inputs = [
    "longAmount",
    "longBalanceDelta",
    "makerAccount",
    "matchId",
    "newLongPosition",
    "newShortPosition",
    "orderDirection",
    "orderFillHash",
    "price",
    "shortAmount",
    "shortBalanceDelta",
    "takerAccount",
    "token"
] %}

with dapp_model as (
    {{ dapp_model(type=type, namespace=namespace, contract_name=contract_name, abi_name=abi_name, inputs=abi_inputs) }}
)

select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    transaction_index,
    log_index,
    contract_address,

    -- ABI Inputs
    toUInt256(longAmount) as longAmount,
    toInt256(longBalanceDelta) as longBalanceDelta,
    lower(makerAccount) as makerAccount,
    toUInt256(matchId) as matchId,
    toInt256(newLongPosition) as newLongPosition,
    toInt256(newShortPosition) as newShortPosition,
    toInt8(orderDirection) as orderDirection,
    toUInt256(orderFillHash) as orderFillHash,
    toUInt64(price) as price,
    toUInt256(shortAmount) as shortAmount,
    toInt256(shortBalanceDelta) as shortBalanceDelta,
    lower(takerAccount) as takerAccount,
    lower(token) as token
from dapp_model
