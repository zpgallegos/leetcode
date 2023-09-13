-- https://leetcode.com/problems/department-top-three-salaries/

with cte as (
    select
        *,
        dense_rank() over(partition by departmentId order by salary desc) as rnk
    from employee
)

select
    d.name as Department,
    e.name as Employee,
    e.salary as Salary
from cte e
    inner join department d on e.departmentId = d.id
where e.rnk <= 3;