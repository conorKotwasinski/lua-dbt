{{ config(materialized='view', schema='prices') }}


select *
from prices.eth_usd_raw