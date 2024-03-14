-- https://leetcode.com/problems/second-highest-salary/

with cte as (
    select *, dense_rank() over(order by salary desc) as rn
    from employee
)

select max(salary) as SecondHighestSalary -- max to return null instead of empty table
from cte
where rn = 2;