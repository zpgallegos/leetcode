-- https://leetcode.com/problems/second-highest-salary/

select max(salary) as SecondHighestSalary
from employee
where salary < (select max(salary) from employee);