{{ config(
    materialized="view"
) }}

select 
    rd.reservation_date,
    rd.site_id,
    rd.site_name,
    rd.service_type,
    max(rd.service_count) as max_services_reserved,
    sum(rd.lesson_needed::int) as total_lessons_reserved,
    count(*) as total_reservations
from {{ ref('int_reservation_details') }} rd
where rd.reservation_status != 'CANCELLED'
group by rd.reservation_date, rd.site_id, rd.site_name, rd.service_type