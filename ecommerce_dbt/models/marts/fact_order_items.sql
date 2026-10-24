{{ config(materialized='table') }}

SELECT
    oi.order_id,
    oi.order_item_id,

    o.customer_id,
    oi.product_id,
    oi.seller_id,

    o.order_date AS date_key,
    o.order_status,
    o.order_purchase_timestamp,

    oi.shipping_limit_date,

    oi.item_price,
    oi.freight_value,
    oi.item_total_value

FROM {{ ref('stg_order_items') }} AS oi

LEFT JOIN {{ ref('stg_orders') }} AS o
    ON oi.order_id = o.order_id