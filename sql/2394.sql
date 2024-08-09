-- https://leetcode.com/problems/employees-with-deductions/

with worked as (
    select
        a.employee_id,
        ceiling(sum(timestampdiff(second, a.in_time, a.out_time)) / 60) / 60 as total_hrs
    from logs a
    group by 1
),
cte as (
    select
        a.employee_id,
        a.needed_hours,
        coalesce(b.total_hrs, 0) as total_hrs
    from employees a
        left join worked b on a.employee_id = b.employee_id
)

select a.employee_id
from cte a
where a.total_hrs < a.needed_hours;