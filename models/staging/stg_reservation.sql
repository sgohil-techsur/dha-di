{{ config(
    materialized="view"
) }}

select
    r.id,
    ({{ dbt_date.from_unixtimestamp("r.created / 1000000") }} - '5 hour'::interval) as created,
    r.created_by,
    ({{ dbt_date.from_unixtimestamp("r.updated / 1000000") }} - '5 hour'::interval) as updated,
    r.updated_by,
    r.customer_id,
    r.lesson_needed,
    r.reservation_confirmation,
    r.reservation_status,
    r.site_id,
    r.waiver_date_time::timestamp as waiver_date_time,
    '1970-01-01'::date+ r.reservation_date as reservation_date,
    (r.start_time * INTERVAL '1 millisecond' /1000)::time as start_time,
    (r.end_time * INTERVAL '1 millisecond' /1000)::time as end_time
from {{ source('reservationservice', 'reservation') }} r