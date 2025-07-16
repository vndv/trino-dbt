{{
    config(
        materialized='incremental',
        unique_key='customer_id',
        incremental_strategy='merge',
        full_refresh = false,
        properties={
        "partitioning": "ARRAY['month(first_ordered_at)']",
        },
        post_hook=[' {{ optimize_tables(this) }} '],
    )
}}


WITH

customer_orders_summary AS (

  SELECT
    customer_id,

    count(DISTINCT order_id) AS count_lifetime_orders,
    count(DISTINCT order_id) > 1 AS is_repeat_buyer,
    min(ordered_at) AS first_ordered_at,
    max(ordered_at) AS last_ordered_at,
    sum(subtotal) AS lifetime_spend_pretax,
    sum(tax_paid) AS lifetime_tax_paid,
    sum(order_total) AS lifetime_spend

  FROM {{ ref('stg_orders') }}

  GROUP BY 1

),

joined AS (

  SELECT
    c.*,

    cus.count_lifetime_orders,
    cus.first_ordered_at,
    cus.last_ordered_at,
    cus.lifetime_spend_pretax,
    cus.lifetime_tax_paid,
    cus.lifetime_spend,

    CASE
      WHEN cus.is_repeat_buyer THEN 'returning'
      ELSE 'new'
    END AS customer_type

  FROM {{ ref('stg_customers') }} AS c

  LEFT JOIN customer_orders_summary AS cus
    ON c.customer_id = cus.customer_id

  {% if is_incremental() %}
    WHERE cus.last_ordered_at >= (SELECT max(last_ordered_at) FROM {{ this }})
  {% endif %}

)

SELECT * FROM joined
