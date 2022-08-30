{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "call" %}
{% set namespace = "UniswapV2" %}
{% set contract_name = "Router02" %}
{% set abi_name = "addLiquidity" %}
{% set abi_inputs = [
    "to",
    "tokenA",
    "tokenB",
    "amountADesired",
    "amountAMin",
    "amountBDesired",
    "amountBMin",
    "deadline"
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
    contract_address,
    caller_address,
    call_success,

    -- ABI Inputs
    lower(to) as to,
    lower(tokenA) as tokenA,
    lower(tokenB) as tokenB,
    toUInt256(amountADesired) as amountADesired,
    toUInt256(amountBDesired) as amountBDesired,
    toUInt256(amountAMin) as amountAMin,
    toUInt256(amountBMin) as amountBMin,
    toUInt256(deadline) as deadline
from dapp_model
