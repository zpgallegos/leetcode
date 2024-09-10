-- https://leetcode.com/problems/status-of-flight-tickets/description/

select
    a.passenger_id,
    case
    when row_number() over win <= b.capacity then 'Confirmed'
    else 'Waitlist'
    end as Status
from passengers a
    inner join flights b on a.flight_id = b.flight_id
window win as (partition by a.flight_id order by a.booking_time)
order by 1;