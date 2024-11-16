-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/


with agg as (
    select
        a.reports_to as employee_id,
        count(1) as reports_count,
        round(avg(age)) as average_age
    from employees a
    group by 1
)

select
    a.employee_id,
    b.name,
    a.reports_count,
    a.average_age
from agg a
    inner join employees b on a.employee_id = b.employee_id
order by 1;