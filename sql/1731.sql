-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/


select
    a.reports_to as employee_id,
    b.name,
    count(1) as reports_count,
    round(avg(a.age)) as average_age
from employees a
    inner join employees b on a.reports_to = b.employee_id
group by 1, 2
order by 1;


-- maybe neater?


with cte as (
    select
        reports_to as employee_id,
        count(1) as reports_count,
        round(avg(age)) as average_age
    from employees
    group by 1
)

select
    a.employee_id,
    b.name,
    a.reports_count,
    a.average_age
from cte a
    inner join employees b on a.employee_id = b.employee_id
order by 1;