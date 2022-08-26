-- https://leetcode.com/problems/department-top-three-salaries/

with cte as (
    select *, dense_rank() over win as rnk
    from employee 
    window win as (partition by departmentId order by salary desc)
)

select
    department.name as Department,
    s.name as Employee,
    s.salary as Salary
    
from (
    select *
    from cte
    where rnk <= 3
) s inner join department on s.departmentId = department.id
