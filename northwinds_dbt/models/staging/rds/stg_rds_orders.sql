with orders as (
    SELECT * FROM {{ source('postgres', 'orders') }}
),

order_details as (
  SELECT * FROM {{ source('postgres', 'order_details') }} 
),

final as (
    SELECT  
    orders.order_id,
    order_date,
    {% set columns = ['product_id', 'employee_id', 'customer_id'] %}
    {% for column in columns %}
        'rds-' || {{ column }} as {{ column }},
    {% endfor %}
    quantity,
    discount,
    unit_price
    FROM orders
    JOIN order_details
    ON orders.order_id = order_details.order_id
)

SELECT * FROM final

-- psql -d northwinds -c "select * from dev.stg_rds_orders limit 3;"