SELECT
  id AS customer_id,
  name AS customer_name
FROM {{ source('source_api_data', 'customers') }}
