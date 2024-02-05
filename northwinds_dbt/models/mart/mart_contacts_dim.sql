{{ config(materialized='table') }}

WITH int_contacts as (
    SELECT * FROM {{ ref('int_contacts') }}
),

int_companies as (
    SELECT * FROM {{ ref('int_companies') }}
),

merged_contacts as (
    SELECT
    contact_pk,
    first_name,
    last_name,
    phone,
    company_pk
    FROM int_contacts con
    LEFT JOIN int_companies comp
    ON con.hubspot_company_id = comp.hubspot_company_id
    OR con.rds_company_id = comp.rds_company_id
)

SELECT * FROM merged_contacts

-- psql -d northwinds -c "select * from dev.mart_contacts_dim limit 3"