WITH contacts as (
  SELECT * FROM {{ source('postgres', 'northwinds_hubspot') }} 
),

companies as (
  SELECT * FROM {{ ref('stg_hubspot_companies') }}
),

renamed as (
    SELECT 
    concat('hubspot-', hubspot_id) as customer_id, 
    first_name,
    last_name,
    REPLACE(TRANSLATE(phone, '(,),-,.', ''), ' ', '') as updated_phone,
    company_id
    FROM contacts
    JOIN companies
    ON contacts.business_name = companies.name
),

final as (
    SELECT
    customer_id,
    first_name,
    last_name,
    CASE WHEN LENGTH(updated_phone) = 10 THEN
        '(' || SUBSTRING(updated_phone, 1, 3) || ') ' || 
        SUBSTRING(updated_phone, 4, 3) || '-' ||
        SUBSTRING(updated_phone, 7, 4) 
    END as phone,
    company_id
    FROM renamed
)

SELECT * FROM final

-- psql -d northwinds -c "select * from dev.northwinds_hubspot limit 3"
-- psql -d northwinds -c "select * from dev.stg_hubspot_contacts order by last_name limit 3"