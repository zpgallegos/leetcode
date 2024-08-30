-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

with qual as (
    select managerId
    from employee
    group by managerId
    having count(1) >= 5
)


select b.name
from qual a 
    inner join employee b on a.managerId = b.id
