{{ config(
    materialized='table',
    full_refresh = false,
    )
}}


SELECT
  t.id,
  t.order_id,
  t.sku
FROM {{ source('source_api_data', 'orders') }}
CROSS JOIN UNNEST("items") AS t (id, order_id, sku)
