-- https://leetcode.com/problems/department-highest-salary/submissions/?lang=pythondata%3FenvType%3Ddaily-question&envId=2023-09-01

with cte as (
    select
        e.name as Employee,
        e.salary as Salary,
        d.name as Department

    from employee e
        inner join department d on e.departmentId = d.id

),
mx as (
    select Department, max(Salary) as dep_max
    from cte
    group by Department
)

select cte.*
from cte
    inner join mx on cte.Department = mx.Department and cte.Salary = mx.dep_max;