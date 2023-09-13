-- https://leetcode.com/problems/department-highest-salary/

with cte as (
    select
        *,
        dense_rank() over win as rnk
    from employee
    window win as (partition by departmentId order by salary desc)
)

select
    b.name as Department,
    a.name as Employee,
    a.salary as Salary

from
    cte a inner join department b on a.departmentId = b.id

where rnk = 1;

--

select
    d.name as Department,
    e.name as Employee,
    e.salary as Salary
from employee e
    inner join department d on e.departmentId = d.id
where (e.departmentId, e.salary) in (select departmentId, max(salary) from employee group by departmentId);

--

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