{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "call" %}
{% set namespace = "Degens" %}
{% set contract_name = "Degens" %}
{% set abi_name = "matchOrders" %}
{% set abi_inputs = ["matchId", "packedLeftOrder", "packedRightOrders", "token"] %}

with dapp_model as (
    {{ dapp_model(type=type, namespace=namespace, contract_name=contract_name, abi_name=abi_name, inputs=abi_inputs) }}
)

select
    block_number,
    block_hash,
    block_timestamp,
    transaction_hash,
    transaction_index,
    contract_address,
    caller_address,
    call_success,

    -- ABI Inputs
    toUInt256(matchId) as matchId,
    packedLeftOrder,
    packedRightOrders,
    lower(token) as token
from dapp_model
