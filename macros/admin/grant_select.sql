{% macro grant_select(table) %}
{% if target.name == 'prod' %}
    {{ log("Granting SELECT on " ~ table) }}
    {% set sql %}
        grant on cluster 'lua-2' select, show tables on {{ table }} to demo_user, teams_admin
    {% endset %}
    {% do run_query(sql) %}
{% else %}
    select 1;
{% endif %}
{% endmacro %}
