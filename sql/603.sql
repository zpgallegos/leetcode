-- https://leetcode.com/problems/consecutive-available-seats/


select s.seat_id 
from (
    select
        *,
        lag(free, 1) over(order by seat_id) as lg,
        lead(free, 1) over(order by seat_id) as ld
    from Cinema
) s
where s.free and (s.lg or s.ld)
order by seat_id;
