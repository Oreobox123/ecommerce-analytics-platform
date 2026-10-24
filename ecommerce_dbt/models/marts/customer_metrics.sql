{{ config(materialized='table') }}

SELECT
    c.customer_unique_id,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.item_price), 2) AS total_product_spending,
    ROUND(SUM(f.freight_value), 2) AS total_shipping_spending,
    ROUND(SUM(f.item_total_value), 2) AS total_spending,
    MIN(f.date_key) AS first_order_date,
    MAX(f.date_key) AS last_order_date,
    CASE
        WHEN COUNT(DISTINCT f.order_id) = 1
            THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_type
FROM {{ ref('fact_order_items') }} AS f
INNER JOIN {{ ref('dim_customers') }} AS c
    ON f.customer_id = c.customer_id
WHERE f.order_status = 'delivered'
GROUP BY
    c.customer_unique_id