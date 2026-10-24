{{ config(materialized='table') }}

SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(f.item_price), 2) AS product_revenue,
    ROUND(SUM(f.freight_value), 2) AS shipping_charges,
    ROUND(SUM(f.item_total_value), 2) AS total_order_value
FROM {{ ref('fact_order_items') }} AS f
INNER JOIN {{ ref('dim_customers') }} AS c
    ON f.customer_id = c.customer_id
WHERE f.order_status = 'delivered'
GROUP BY
    c.customer_state