-- https://leetcode.com/problems/department-top-three-salaries/

with cte as (
    select
        b.name as Department,
        a.name as Employee,
        a.salary as Salary,
        dense_rank() over w as dep_rank
    from employee a
        inner join department b on a.departmentid = b.id
    window w as (partition by b.id order by a.salary desc)
)

select Department, Employee, Salary
from cte 
where dep_rank <= 3;

