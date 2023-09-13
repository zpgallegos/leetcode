-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/


select name
from employee
where id in(
    select managerId as id
    from employee
    group by managerId
    having count(1) >= 5
);

select employee.name
from (
    select managerId
    from employee
    group by managerId
    having count(1) >= 5
    ) sub inner join employee on sub.managerId = employee.id;