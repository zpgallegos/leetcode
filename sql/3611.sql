-- https://leetcode.com/problems/find-overbooked-employees/


with heavy as (
    select
        employee_id,
        to_char(meeting_date, 'IYYY-IW') as wk
    from meetings
    group by 1, 2
    having sum(duration_hours) > 20
),

cnts as (
    select employee_id, count(1) as meeting_heavy_weeks
    from heavy
    group by 1
    having count(1) > 1
)

select
    a.employee_id,
    b.employee_name,
    b.department,
    a.meeting_heavy_weeks
from cnts a
inner join employees b on a.employee_id = b.employee_id
order by 4 desc, 2;