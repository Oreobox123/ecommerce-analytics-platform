{{ config(materialized='table') }}

WITH date_spine AS (

    SELECT
        DATEADD(
            day,
            SEQ4(),
            '2016-01-01'::DATE
        ) AS date_day

    FROM TABLE(GENERATOR(ROWCOUNT => 1461))

)

SELECT
    date_day AS date_key,

    YEAR(date_day) AS year,

    QUARTER(date_day) AS quarter,

    MONTH(date_day) AS month_number,

    MONTHNAME(date_day) AS month_name,

    DAY(date_day) AS day_of_month,

    DAYOFWEEKISO(date_day) AS day_of_week,

    DAYNAME(date_day) AS day_name,

    WEEKISO(date_day) AS week_of_year,

    CASE
        WHEN DAYOFWEEKISO(date_day) IN (6, 7)
        THEN TRUE
        ELSE FALSE
    END AS is_weekend

FROM date_spine