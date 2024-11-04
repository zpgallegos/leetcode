-- https://leetcode.com/problems/employees-with-missing-information/


select coalesce(a.employee_id, b.employee_id) as employee_id
from employees a full outer join salaries b on a.employee_id = b.employee_id
where a.name is null or b.salary is null
order by 1;
