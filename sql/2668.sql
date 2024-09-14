-- https://leetcode.com/problems/find-latest-salaries/description/

with cte as (
    select
        a.*,
        rank() over win as rnk
    from salary a
    window win as (partition by a.emp_id order by a.salary desc)
)

select emp_id, firstname, lastname, salary, department_id
from cte
where rnk = 1
order by 1;