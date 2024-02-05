WITH hubspot as (
  SELECT * FROM {{ ref('stg_hubspot_companies') }}
),

companies as (
  SELECT * FROM {{ ref('stg_rds_companies') }} 
),

merged_companies as (
    SELECT
    company_id as hubspot_company_id,
    null as rds_company_id,
    name,
    null as address,
    null as city,
    null as postal_code,
    null as country
    FROM hubspot

    UNION ALL

    SELECT
    null as hubspot_company_id,
    company_id as rds_company_id,
    name,
    address,
    city,
    postal_code,
    country
    FROM companies
),

final as (
    SELECT
    max(hubspot_company_id) as hubspot_company_id, 
    max(rds_company_id) as rds_company_id,
    name,
    max(address) as address,
    max(city) as city,
    max(postal_code) as postal_code,
    max(country) country
    FROM merged_companies
    GROUP BY name
)

select {{ dbt_utils.generate_surrogate_key(['name']) }} as company_pk,
hubspot_company_id, rds_company_id,
name, address, city, postal_code, country from final

-- psql -d northwinds -c "select * from dev.int_companies limit 3"