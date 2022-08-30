{% macro grant_select_on_databases(databases, users) %}
{% if target.name == 'prod' %}
    {#
        Create a cartesian product of databases and users and then grant read-only
        access to the entire database to the user.
    #}
    {% for database in databases %}
        {% for user in users %}
            {% set sql %}
            grant on cluster 'lua-2' select, show tables on {{ database }}.* to {{ user }}
            {% endset %}
            {% do run_query(sql) %}
        {% endfor %}
    {% endfor %}
{% endif %}
{% endmacro %}
