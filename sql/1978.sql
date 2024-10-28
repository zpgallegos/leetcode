-- https://leetcode.com/problems/employees-whose-manager-left-the-company/description/

select a.employee_id
from employees a
    left join employees b on a.manager_id = b.employee_id
where
    1=1
    and a.salary < 30000
    and a.manager_id is not null
    and b.employee_id is null
order by 1;
