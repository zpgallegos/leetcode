-- https://leetcode.com/problems/find-drivers-with-improved-fuel-efficiency/


with averages as (
    select
        driver_id,
        avg(distance_km / fuel_consumed) filter(where extract(month from trip_date) <= 6) as first_half_avg,
        avg(distance_km / fuel_consumed) filter(where extract(month from trip_date) > 6) as second_half_avg
    from trips
    group by 1
)

select
    a.driver_id,
    b.driver_name,
    round(a.first_half_avg, 2) as first_half_avg,
    round(a.second_half_avg, 2) as second_half_avg,
    round(second_half_avg - first_half_avg, 2) as efficiency_improvement 
from averages a
inner join drivers b on a.driver_id = b.driver_id
where a.second_half_avg > a.first_half_avg
order by 5 desc, 2;