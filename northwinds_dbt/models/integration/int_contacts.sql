WITH hubspot as (
  SELECT * FROM {{ ref('stg_hubspot_contacts') }}
),

customers as (
  SELECT * FROM {{ ref('stg_rds_customers') }} 
),

merged_contacts as (
    SELECT
    customer_id as hubspot_contact_id,
    null as rds_contact_id,
    first_name,
    last_name,
    phone,
    company_id as hubspot_company_id,
    null as rds_company_id
    FROM hubspot

    UNION ALL

    SELECT
    null as hubspot_contact_id,
    customer_id as rds_contact_id,
    first_name,
    last_name,
    phone,
    null as hubspot_company_id,
    company_id as rds_company_id
    FROM customers
),

renamed as (
    SELECT
    max(hubspot_contact_id) as hubspot_contact_id, 
    max(rds_contact_id) as rds_contact_id,
    first_name,
    last_name,
    MAX(phone) as phone,
    max(hubspot_company_id) as hubspot_company_id,
    max(rds_company_id) rds_company_id
    FROM merged_contacts
    GROUP BY first_name, last_name
)

SELECT * FROM renamed

-- psql -d northwinds -c "select * from dev.int_contacts order by last_name limit 20"