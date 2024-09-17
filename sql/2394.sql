-- https://leetcode.com/problems/employees-with-deductions/

with cte as (
    select
        a.employee_id,
        sum(ceiling(extract(epoch from a.out_time - a.in_time) / 60)) / 60 as hrs
    from logs a
    group by 1
)

select a.employee_id
from employees a
    left join cte b on a.employee_id = b.employee_id
where 
    b.hrs is null or 
    b.hrs < a.needed_hours
order by 1;