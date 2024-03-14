-- https://leetcode.com/problems/department-top-three-salaries/

with cte as (
    select *, dense_rank() over(partition by departmentId order by salary desc) as rnk
    from employee
)

select
    b.name as Department,
    a.name as Employee,
    a.salary as Salary
from cte a
    inner join department b on a.departmentId = b.id
where a.rnk <= 3;