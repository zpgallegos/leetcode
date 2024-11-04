-- https://leetcode.com/problems/second-highest-salary-ii/description/

with cte as (
    select
        a.*,
        dense_rank() over win as rnk
    from employees a
    window win as (partition by a.dept order by a.salary desc)
)

select emp_id, dept
from cte
where rnk = 2
order by 1;