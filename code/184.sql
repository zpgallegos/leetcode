-- https://leetcode.com/problems/department-highest-salary/

with cte as (
    select
        *,
        rank() over w as rnk
    from employee
    window w as (partition by departmentid order by salary desc)
)

select
    b.name as Department,
    a.name as Employee,
    a.salary

from department b inner join (
    select * from cte
    where rnk = 1
    ) a on a.departmentid = b.id;