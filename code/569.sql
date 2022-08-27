-- https://leetcode.com/problems/median-employee-salary/

with cte as (
    select
        *,
        row_number() over(partition by company order by salary) as rw,
        count(1) over(partition by company) as recs
    from employee
)

select id, company, salary
from cte
where
    (mod(recs, 2) = 0 and rw in (recs / 2, recs / 2 + 1)) or
    (mod(recs, 2) = 1 and rw = round(recs / 2))

