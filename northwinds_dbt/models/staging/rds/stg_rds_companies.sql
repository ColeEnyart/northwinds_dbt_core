with source as (
    SELECT * FROM {{ source('postgres', 'customers')}}
),

renamed as (
    SELECT  
    concat('rds-',replace(lower(company_name), ' ', '-')) as company_id,
    company_name as name,
    max(address) as address,
    max(city) as city,
    max(postal_code) as postal_code,
    max(country) as country
    FROM source
    GROUP BY company_name

)

SELECT * FROM renamed

-- psql -d northwinds -c "select * from dev.stg_rds_companies order by company_id limit 3"