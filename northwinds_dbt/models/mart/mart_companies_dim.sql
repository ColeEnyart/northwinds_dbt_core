{{ config(materialized='table') }}

WITH int_companies as (
    select * from {{ ref('int_companies') }}
)
select company_pk, name, address, postal_code, city, country from int_companies 

-- psql -d northwinds -c "select * from dev.mart_companies_dim limit 3"