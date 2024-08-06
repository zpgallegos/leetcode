-- https://leetcode.com/problems/status-of-flight-tickets/

select
    a.passenger_id,
    if(row_number() over(partition by a.flight_id order by a.booking_time) <= b.capacity, 'Confirmed', 'Waitlist') as Status
from passengers a
    inner join flights b on a.flight_id = b.flight_id
order by a.passenger_id;