{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "event" %}
{% set namespace = "UniswapV2" %}
{% set contract_name = "Pair" %}
{% set abi_name = "Swap" %}
{% set abi_inputs = ["sender", "to", "amount0In", "amount1In", "amount0Out", "amount1Out"] %}

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
    lower(sender) as sender,
    lower(to) as to,
    toUInt256(amount0In) as amount0In,
    toUInt256(amount1In) as amount1In,
    toUInt256(amount0Out) as amount0Out,
    toUInt256(amount1Out) as amount1Out
from dapp_model
