with source as (
    select contact_name, address, phone from {{ source('postgres', 'customers') }}
)

select * from source