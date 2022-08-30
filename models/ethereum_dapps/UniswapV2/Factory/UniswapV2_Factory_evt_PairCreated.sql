{{ config(
    materialized="incremental",
    engine="ReplicatedMergeTree()",
    order_by=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    unique_key=["block_number", "block_timestamp", "transaction_hash", "transaction_index"],
    inserts_only=true
) }}

{% set type = "event" %}
{% set namespace = "UniswapV2" %}
{% set contract_name = "Factory" %}
{% set abi_name = "PairCreated" %}
{% set abi_inputs = ["pair", "token0", "token1", ""] %}
{% set alias_map = {"": "allPairs_length"} %}

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
    log_index,
    contract_address,

    -- ABI Inputs
    lower(pair) as pair,
    lower(token0) as token0,
    lower(token1) as token1,
    toUInt256(allPairs_length) as allPairs_length
from dapp_model
