-- https://leetcode.com/problems/median-employee-salary/description/

with cte as (
    select 
        *, 
        row_number() over(partition by company order by salary, id) as row_n,
        count(1) over(partition by company) as row_count
    from employee
)

select
    id,
    company,
    salary
from cte
where
    (mod(row_count, 2) = 0 and row_n in(row_count / 2, row_count / 2 + 1)) or
    (mod(row_count, 2) = 1 and row_n = (row_count + 1) / 2);
