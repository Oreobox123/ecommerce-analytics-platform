{{ config(materialized='table') }}

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(f.item_price), 2) AS product_revenue,
    ROUND(SUM(f.freight_value), 2) AS shipping_charges,
    ROUND(SUM(f.item_total_value), 2) AS total_order_value,
    ROUND(AVG(f.item_price), 2) AS avg_item_price
FROM {{ ref('fact_order_items') }} AS f
INNER JOIN {{ ref('dim_sellers') }} AS s
    ON f.seller_id = s.seller_id
WHERE f.order_status = 'delivered'
GROUP BY
    s.seller_id,
    s.seller_city,
    s.seller_state