-- https://leetcode.com/problems/employees-with-deductions/

select e.employee_id
from employees e
    left join (
        select
            employee_id,
            sum(ceiling(timestampdiff(second, in_time, out_time) / 60)) / 60 as hrs
        from logs
        group by employee_id
    ) s on e.employee_id = s.employee_id
where s.employee_id is null or s.hrs < e.needed_hours;

        