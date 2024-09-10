-- https://leetcode.com/problems/manager-of-the-largest-department/description/

with cte as (
    select
        s.*,
        rank() over win as rnk
    from (
        select
            dep_id,
            count(1) as n_emps
        from employees
        group by 1
    ) s
    window win as (order by s.n_emps desc)
)

select
    b.emp_name as manager_name,
    a.dep_id
from cte a
    inner join employees b on a.dep_id = b.dep_id
where a.rnk = 1 and b.position = 'Manager'
order by 2;