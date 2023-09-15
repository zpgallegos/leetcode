-- https://leetcode.com/problems/find-latest-salaries/

with cte as (
    select emp_id, firstname, lastname, max(salary) as salary, department_id
    from salary
    group by emp_id, firstname, lastname, department_id
)

select * from cte order by emp_id;
