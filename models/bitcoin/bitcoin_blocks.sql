{{ config(materialized='view', alias='blocks', schema='bitcoin') }}


select *
from bitcoin.blocks_raw