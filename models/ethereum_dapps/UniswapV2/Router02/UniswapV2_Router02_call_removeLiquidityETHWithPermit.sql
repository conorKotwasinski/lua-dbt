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
{% set abi_name = "removeLiquidityETHWithPermit" %}
{% set abi_inputs = [
    "to",
    "token",
    "amountETHMin",
    "amountTokenMin",
    "approveMax",
    "liquidity",
    "deadline",
    "r",
    "s",
    "v"
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
    lower(token) as token,
    toUInt256(amountETHMin) as amountETHMin,
    toUInt256(amountTokenMin) as amountTokenMin,
    approveMax,
    toUInt256(liquidity) as liquidity,
    toUInt256(deadline) as deadline,
    r,
    s,
    v
from dapp_model
