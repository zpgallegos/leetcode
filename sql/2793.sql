-- https://leetcode.com/problems/status-of-flight-tickets/

with cte as (
    select
        p.passenger_id,
        p.flight_id,
        f.capacity,
        row_number() over(partition by p.flight_id order by p.booking_time) as ord

    from passengers p
        inner join flights f on p.flight_id = f.flight_id
)

select passenger_id, if(ord <= capacity, "Confirmed", "Waitlist") as Status
from cte
order by passenger_id;