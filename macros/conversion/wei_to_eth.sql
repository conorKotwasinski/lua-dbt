{%- macro wei_to_eth(wei_value) -%}
({{ wei_value }} / 1e18)
{%- endmacro -%}
