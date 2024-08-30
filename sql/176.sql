-- https://leetcode.com/problems/second-highest-salary/description/

with cte as (
    select
        a.salary,
        dense_rank() over win as rnk
    from employee a
    window win as (order by a.salary desc)
)

select max(salary) as SecondHighestSalary
from cte
where rnk = 2;