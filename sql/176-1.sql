-- https://leetcode.com/problems/second-highest-salary/solutions/?lang=pythondata

-- nth largest salary

with ranked as (
    select
        salary,
        dense_rank() over(order by salary desc) as rnk
    from
        employee
)

select max(salary) as SecondHighestSalary
from ranked
where rnk = 2;
