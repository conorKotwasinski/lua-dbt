{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {% if target.name == "dev" %}

            {{ target.schema }}

        {%- else -%}
        
            {{ default_schema }}

        {% endif %}

    {%- else -%}

        {% if target.name == "dev" %}

            {{ target.schema }}_{{ custom_schema_name | trim }}

        {%- else -%}
        
            {{ custom_schema_name | trim }}

        {% endif %}

    {%- endif -%}

{%- endmacro %}
