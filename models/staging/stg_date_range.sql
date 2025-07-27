select generate_series(
    current_date - '1 year'::interval, 
    current_date + '1 year'::interval, 
    '1 day'::interval
)::date as date