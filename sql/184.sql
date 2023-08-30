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