{{ config(materialized='table') }}

SELECT
    DATE_TRUNC('MONTH', date_key)::DATE AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(item_price), 2) AS product_revenue,
    ROUND(SUM(freight_value), 2) AS shipping_charges,
    ROUND(SUM(item_total_value), 2) AS total_order_value
FROM {{ ref('fact_order_items') }}
WHERE order_status = 'delivered'
GROUP BY
    DATE_TRUNC('MONTH', date_key)::DATE