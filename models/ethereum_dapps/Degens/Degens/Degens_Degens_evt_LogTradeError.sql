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
{% set abi_name = "LogTradeError" %}
{% set abi_inputs = ["makerAccount", "matchId", "orderFillHash", "status", "takerAccount", "token"] %}

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
    lower(makerAccount) as makerAccount,
    toUInt256(matchId) as matchId,
    toUInt256(orderFillHash) as orderFillHash,
    toUInt16(status) as status,
    lower(takerAccount) as takerAccount,
    lower(token) as token
from dapp_model
