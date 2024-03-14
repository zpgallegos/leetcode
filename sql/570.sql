-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/


with cte as (
    select managerId
    from employee
    group by managerId
    having count(distinct id) >= 5
)

select name
from employee
where id in(select * from cte);