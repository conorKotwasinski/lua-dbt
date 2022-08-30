{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "call" %}
{% set namespace = "UniswapV2" %}
{% set contract_name = "Pair" %}
{% set abi_name = "approve" %}
{% set abi_inputs = ["spender", "value"] %}

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
    lower(spender) as spender,
    toUInt256(value) as value
from dapp_model
