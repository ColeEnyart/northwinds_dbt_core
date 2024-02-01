with source as (
    SELECT * FROM public.suppliers
),

renamed as (
    SELECT *,
    split_part(contact_name, ' ', 1) as contact_first_name,
    split_part(contact_name, ' ', 2) as contact_last_name
    FROM source
),

phone_filter as (
    SELECT *,
    translate(phone, '-,(,),., ', '') as phone_filter
    FROM renamed
),

phone_formated as (
    SELECT *,
    CASE
        WHEN LENGTH(phone_filter) = 10 THEN FORMAT('(%s)-%s-%s', SUBSTRING(phone_filter, 1, 3), SUBSTRING(phone_filter, 4, 3), SUBSTRING(phone_filter, 7, 3))
    ELSE
        Null
    END AS phone_formated
    FROM phone_filter
),

sort as (
    SELECT contact_name, contact_first_name, contact_last_name,
    phone, phone_filter, phone_formated
    FROM phone_formated
)

SELECT * FROM sort

-- psql -d northwinds -c "select LENGTH(translate(phone, '-,(,),., ', '')) as phone_length, COUNT(*) as amount from dev.stg_rds_suppliers group by phone_length order by phone_length DESC"