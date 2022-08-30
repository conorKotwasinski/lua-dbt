{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "call" %}
{% set namespace = "UniswapV2" %}
{% set contract_name = "Factory" %}
{% set abi_name = "getPair" %}
{% set abi_inputs = [""] %}
{% set alias_map = {"": "pair"} %}

with dapp_model as (
    {{ dapp_model(
        type=type,
        namespace=namespace,
        contract_name=contract_name,
        abi_name=abi_name,
        inputs=abi_inputs,
        alias_map=alias_map
    ) }}
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
    lower(pair) as pair
from dapp_model
