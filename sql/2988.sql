-- https://leetcode.com/problems/manager-of-the-largest-department/description/

with cte as (
    select
        *,
        rank() over(order by cnt desc) as rnk
    from (
        select dep_id, count(1) as cnt
        from employees
        group by dep_id
    ) sub
)

select b.emp_name as manager_name, a.dep_id
from cte a
    inner join employees b on a.dep_id = b.dep_id
where a.rnk = 1 and b.position = 'Manager'
order by a.dep_id;