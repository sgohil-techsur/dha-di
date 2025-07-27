{{ config(
    materialized="view"
) }}

select
    *,
    (rd.reservation_date + rd.start_time) as reservation_start_timestamp,
    (rd.reservation_date + rd.end_time) as reservation_end_timestamp
from {{ ref('int_reservation_details') }} rd
where rd.reservation_date = CURRENT_DATE