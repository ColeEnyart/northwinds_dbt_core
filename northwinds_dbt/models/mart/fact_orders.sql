{{ config(materialized='table') }}

WITH int_orders as (
    SELECT * FROM {{ ref('int_orders') }}
),

int_contacts as (
    SELECT contact_pk, rds_contact_id FROM {{ ref('int_contacts') }}
),

merge_orders as (
    SELECT *
    FROM int_orders
    JOIN int_contacts
    ON int_orders.customer_id = int_contacts.rds_contact_id
),

final as (
    SELECT
    order_pk,
    contact_pk,
    {{ dbt_utils.star(from=ref('int_orders'), except=['order_pk', 'customer_id']) }}
    FROM merge_orders
    ORDER BY order_date
)

SELECT * FROM final

-- psql -d northwinds -c "select * from dev.fact_orders limit 5;"