{{ config(
    materialized="view"
) }}

select 
    dss.*,
    round((dss.max_services_reserved::numeric / dss.service_count), 3) as service_utilization_rate,
    round(coalesce((dss.total_lessons_reserved::numeric / nullif(dss.total_reservations, 0)), 0), 3) as lesson_reservation_rate,
    (dss.reservation_date + '5 hour'::interval) as reservation_date_utc
from (
    select 
        dr.date as reservation_date,
        sd.site_id,
        sd.site_name,
        sd.service_type,
        sd.service_count,
        coalesce(dsr.total_reservations, 0) as total_reservations,
        coalesce(dsr.max_services_reserved, 0) as max_services_reserved,
        coalesce((sd.service_count - dsr.max_services_reserved), sd.service_count) as services_remaining_count,
        coalesce(dsr.total_lessons_reserved, 0) as total_lessons_reserved
    from {{ ref('int_service_details') }} sd
    cross join {{ ref('stg_date_range') }} dr
    left join {{ ref('int_daily_services_reserved') }} dsr
    on sd.site_id = dsr.site_id and sd.service_type = dsr.service_type and dsr.reservation_date = dr.date
) dss
order by dss.reservation_date