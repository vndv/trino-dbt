SELECT
  id AS order_id,
  customer_id,
  store_id,
  date_parse(ordered_at, '%Y-%m-%dT%H:%i:%s') AS ordered_at,
  cast(subtotal AS int) AS subtotal,
  cast(tax_paid AS int) AS tax_paid,
  cast(order_total AS int) AS order_total
FROM {{ source('source_api_data', 'orders') }}
