{{ config(
    materialized="view"
) }}

select 
    s.id,
    s.site_id,
    si.site_name,
    s.type as service_type,
    s.count as service_count,
    s.cost,
    s.description
from {{ source('inventoryservice', 'service')}} s
left join {{ ref('stg_site') }} si
on s.site_id = si.site_id