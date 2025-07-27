{{ config(
    materialized="view"
) }}

select
    r.id,
    r.created,
    r.created_by,
    r.updated,
    r.updated_by,
    r.customer_id,
    c.first_name as customer_first_name,
    c.last_name as customer_last_name,
    c.email_address as customer_email_address,
    c.phone as customer_phone,
    rs.service_type,
    rs.service_count,
    r.lesson_needed,
    r.reservation_confirmation,
    r.reservation_status,
    r.site_id,
    si.site_name,
    r.waiver_date_time,
    r.reservation_date,
    r.start_time,
    r.end_time,
    (r.created + '5 hour'::interval) as created_utc,
    (r.updated + '5 hour'::interval) as updated_utc,
    (r.waiver_date_time + '5 hour'::interval) as waiver_date_time_utc,
    (r.reservation_date + '5 hour'::interval) as reservation_date_utc,
    (r.start_time + '5 hour'::interval) as start_time_utc,
    (r.end_time + '5 hour'::interval) as end_time_utc
from {{ ref('stg_reservation') }} r
join {{ source('reservationservice', 'customer') }} c
on c.id = r.customer_id
join {{ source('reservationservice', 'reservation_service') }} rs
on r.id = rs.reservation_id
join {{ ref('stg_site') }} si
on r.site_id = si.site_id