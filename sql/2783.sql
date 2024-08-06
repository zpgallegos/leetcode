-- https://leetcode.com/problems/flight-occupancy-and-waitlist-analysis/


with cte as (
    select
        a.flight_id,
        a.capacity,
        count(b.passenger_id) as ps
    from flights a
        left join passengers b on a.flight_id = b.flight_id
    group by a.flight_id
)

select
    a.flight_id,
    if(a.ps <= a.capacity, a.ps, a.capacity) as booked_cnt,
    if(a.ps <= a.capacity, 0, a.ps - a.capacity) as waitlist_cnt
from cte a
order by a.flight_id





