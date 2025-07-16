{%- macro generate_schema_name(custom_schema_name, node) -%}
{# изменяем поведение переменной schema в кастомных конфигах в коде моделей  #}
    {%- set default_schema = target.schema -%}
    {%- if target.name in  ['dev']  and custom_schema_name is not none -%}

        {{ custom_schema_name | trim }}

    {%- else -%}

        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}
