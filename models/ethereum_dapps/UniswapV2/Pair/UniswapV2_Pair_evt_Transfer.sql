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
{% set abi_name = "Transfer" %}
{% set abi_inputs = ["from", "to", "value"] %}

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
    lower(from) as from,
    lower(to) as to,
    toUInt256(value) as value
from dapp_model
