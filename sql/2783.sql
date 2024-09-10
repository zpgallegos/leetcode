-- https://leetcode.com/problems/flight-occupancy-and-waitlist-analysis/

with cte as (
    select
        a.flight_id,
        a.capacity,
        count(b.passenger_id) as npass
    from flights a
        left join passengers b on a.flight_id = b.flight_id
    group by 1, 2
)

select
    flight_id,
    if(npass >= capacity, capacity, npass) as booked_cnt,
    if(npass >= capacity, npass - capacity, 0) as waitlist_cnt
from cte
order by 1;
