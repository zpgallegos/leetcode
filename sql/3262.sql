-- https://leetcode.com/problems/find-overlapping-shifts/description/

select
    a.employee_id,
    count(1) as overlapping_shifts
from employeeshifts a
    inner join employeeshifts b on a.employee_id = b.employee_id
where
    1=1
    and a.start_time < b.start_time
    and b.start_time < a.end_time
group by 1
order by 1;