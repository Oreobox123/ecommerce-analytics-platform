SELECT
    order_id,
    customer_id,
    LOWER(TRIM(order_status)) AS order_status,

    CAST(order_purchase_timestamp AS TIMESTAMP_NTZ)
        AS order_purchase_timestamp,

    CAST(order_approved_at AS TIMESTAMP_NTZ)
        AS order_approved_at,

    CAST(order_delivered_carrier_date AS TIMESTAMP_NTZ)
        AS order_delivered_carrier_date,

    CAST(order_delivered_customer_date AS TIMESTAMP_NTZ)
        AS order_delivered_customer_date,

    CAST(order_estimated_delivery_date AS TIMESTAMP_NTZ)
        AS order_estimated_delivery_date,

    CAST(order_purchase_timestamp AS DATE)
        AS order_date

FROM {{ source('raw', 'orders') }}