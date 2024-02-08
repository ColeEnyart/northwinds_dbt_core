WITH final as (
    SELECT
    {{ dbt_utils.generate_surrogate_key(
        ['order_id', 'order_date', 'product_id', 'customer_id']) }} as order_pk,
    {{ dbt_utils.star(from=ref('stg_rds_orders'), except=['order_id']) }}
    FROM {{ ref('stg_rds_orders') }}
)

SELECT * FROM final

-- psql -d northwinds -c "select * from dev.int_orders limit 3;"