
{{ config(materialized='view') }}

select number, hash, timestamp, size
from blocks as b