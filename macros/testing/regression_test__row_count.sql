{% macro regression_test__row_count(prod, dev) %}
    with a as (
        select count(1) as n
        from {{ prod }}
    ),

    b as (
        select count(1) as n
        from {{ dev }}
    )

    select
        a.n as prod_count,
        b.n as dev_count
    from a, b
    where prod_count != dev_count
{% endmacro %}
