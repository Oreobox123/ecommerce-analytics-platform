{{ config(materialized='table') }}

SELECT
    COALESCE(p.product_category_name_english, 'unknown') AS category,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(f.item_price), 2) AS product_revenue,
    ROUND(SUM(f.freight_value), 2) AS shipping_charges,
    ROUND(SUM(f.item_total_value), 2) AS total_order_value
FROM {{ ref('fact_order_items') }} AS f
LEFT JOIN {{ ref('dim_products') }} AS p
    ON f.product_id = p.product_id
WHERE f.order_status = 'delivered'
GROUP BY
    COALESCE(p.product_category_name_english, 'unknown')