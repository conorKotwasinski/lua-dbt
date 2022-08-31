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
{% set abi_name = "LogCancel" %}
{% set abi_inputs = ["account", "amount", "orderGroup", "token"] %}

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
    lower(account) as account,
    toUInt256(amount) as amount,
    toUInt256(orderGroup) as orderGroup,
    lower(token) as token
from dapp_model