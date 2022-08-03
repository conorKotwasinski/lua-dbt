{% macro grant_select(table) %}
{% if target.name == 'prod' %}
    {% set sql %}
        grant select, show tables on {{ table }} to demo_user, teams_admin
    {% endset %}
    {% do run_query(sql) %}
{% else %}
    select 1;
{% endif %}
{% endmacro %}
