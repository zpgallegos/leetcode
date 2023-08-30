-- https://leetcode.com/problems/employees-whose-manager-left-the-company/

select
    a.employee_id

from employees a
    left join employees b on a.manager_id = b.employee_id

where
    a.manager_id is not null and
    b.employee_id is null and
    a.salary < 30000

order by a.employee_id;

