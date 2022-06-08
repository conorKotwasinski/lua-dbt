{% macro clone_table(database, table, key) %}

{% set dev_database = target.schema %}
{% set dev_table = database ~ "__" ~ table %}
{{ log("Cloning table " ~ database ~ "." ~ table ~ " as " ~ dev_database ~ "." ~ dev_table ~ ". Sample key=" ~ key, info=True) }}

{% set db_create_query %}
create database if not exists {{ dev_database }}
{% endset %}
{% do run_query(db_create_query) %}

{% set view_create_query %}
create view {{dev_database}}.{{dev_table}} as (
    select * from {{database}}.{{table}}
    where cityHash64({{key}}) % 10 = 0 -- deterministic sampling w/o SAMPLE setting on table creation
)
{% endset %}
{% do run_query(view_create_query) %}

{% endmacro %}
