{{ config(materialized='view', schema='prices') }}


select *
from prices.btc_usd_raw