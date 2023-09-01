-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/


select name
from employee
where id in(
    select managerId as id
    from employee
    group by managerId
    having count(1) >= 5
);