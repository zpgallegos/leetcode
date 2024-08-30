-- https://leetcode.com/problems/employees-earning-more-than-their-managers/description/

select a.name as Employee
from employee a
    inner join employee b on a.managerid = b.id
where a.salary > b.salary;