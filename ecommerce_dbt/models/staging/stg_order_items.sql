SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,

    CAST(shipping_limit_date AS TIMESTAMP_NTZ)
        AS shipping_limit_date,

    CAST(price AS NUMBER(12, 2))
        AS item_price,

    CAST(freight_value AS NUMBER(12, 2))
        AS freight_value,

    CAST(price AS NUMBER(12, 2))
        + CAST(freight_value AS NUMBER(12, 2))
        AS item_total_value

FROM {{ source('raw', 'order_items') }}