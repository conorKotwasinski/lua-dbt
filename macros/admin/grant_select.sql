{% macro grant_select(table) %}
{% if target.name == 'prod' %}
    {% set sql %}
        grant on cluster 'lua-2' select, show tables on {{ table }} to demo_user, teams_admin, lua_api
    {% endset %}
    {% do run_query(sql) %}
{% else %}
    select 1;
{% endif %}
{% endmacro %}
