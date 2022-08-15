-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/


select name
from Employee
where id in (
    select managerId
    from Employee
    group by managerId
    having count(distinct id) >= 5
)