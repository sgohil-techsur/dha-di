{{ config(
    materialized="view"
) }}

select
    s.id as site_id,
    ({{ dbt_date.from_unixtimestamp("s.created / 1000000") }} - '5 hour'::interval) as created,
    s.created_by,
    ({{ dbt_date.from_unixtimestamp("s.updated / 1000000") }} - '5 hour'::interval) as updated,
    s.updated_by,
    s.name as site_name,
    s.region_id,
    s.site_address_id,
    s.description,
    (s.start_hour * INTERVAL '1 millisecond' /1000)::time as start_hour,
    (s.end_hour * INTERVAL '1 millisecond' /1000)::time as end_hour,
    s.lessons_offered
from {{ source('inventoryservice', 'site') }} s
