{% macro limit_data_in_dev(column_name) -%}
{% if target.name == 'default' %}
where {{ column_name }} >= (SELECT '2017-12-11'::TIMESTAMP  + '1 day'::INTERVAL)
{% endif %}
{%- endmacro %}