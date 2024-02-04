WITH source as (
  SELECT * FROM {{ source('postgres', 'northwinds_hubspot') }} 
),

renamed as (
    SELECT 
    concat('hubspot-', TRANSLATE(LOWER(business_name), ' ,', '-')) as company_id, 
    business_name as name
    FROM source
    GROUP BY 1, 2
)

SELECT * FROM renamed

-- psql -d northwinds -c "select * from dev.stg_hubspot_companies order by business_name limit 3"