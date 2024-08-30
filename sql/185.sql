-- https://leetcode.com/problems/department-top-three-salaries/description/


with cte as (
    select
        a.*,
        dense_rank() over win as rnk
    from employee a
    window win as (partition by a.departmentid order by a.salary desc)
)

select
    b.name as Department,
    a.name as Employee,
    a.Salary
from cte a
    inner join department b on a.departmentid = b.id
where a.rnk <= 3;
