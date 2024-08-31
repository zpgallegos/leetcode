-- https://leetcode.com/problems/department-highest-salary/description/

with cte as (
    select
        a.*,
        rank() over(partition by a.departmentId order by a.salary desc) as rnk
    from employee a
)

select
    b.name as Department,
    a.name as Employee,
    a.Salary
from cte a
    inner join department b on a.departmentId = b.id
where a.rnk = 1;

---

select
    b.name as Department,
    a.name as Employee,
    a.Salary
from employee a
    inner join department b on a.departmentId = b.id
    inner join (
        select departmentId, max(salary) as mx
        from employee
        group by 1
    ) c on a.departmentId = c.departmentId and a.salary = c.mx;
