{{ config(materialized='view', schema='prices') }}


select *
from prices.sol_usd_raw