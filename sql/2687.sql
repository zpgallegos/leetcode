-- https://leetcode.com/problems/bikes-last-time-used/

select
    a.bike_number,
    max(a.end_time) as end_time
from bikes a
group by 1
order by 2 desc;