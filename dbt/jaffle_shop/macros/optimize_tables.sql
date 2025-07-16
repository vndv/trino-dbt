
{% macro optimize_tables(table) -%}
  {% if execute %}

    {% set optimize_query %}
      ALTER TABLE {{ table }} EXECUTE optimize(file_size_threshold => '10MB');
      ALTER TABLE {{ table }} EXECUTE expire_snapshots(retention_threshold => '0d');
      ALTER TABLE {{ table }} EXECUTE remove_orphan_files(retention_threshold => '0d');
    {% endset %}

    {{ return(optimize_query.strip()) }}

  {% endif %}
{%- endmacro %}
