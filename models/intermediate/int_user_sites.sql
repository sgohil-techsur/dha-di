{{ config(
    materialized="view"
) }}

select 
    lower(rmu.email_address) as email_address, 
    rmu.role, 
    rmu.region_id, 
    si.site_id, 
    si.site_name
from {{ source('userservice', 'pr_user') }} rmu
join {{ ref('stg_site') }} si
on si.region_id = rmu.region_id
where rmu.role = 'regional_manager'