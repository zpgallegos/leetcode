-- https://leetcode.com/problems/all-people-report-to-the-given-manager/description/


with recursive cte as (
    select a.employee_id
    from employees a
    where a.employee_id = 1

    union

    select b.employee_id
    from cte a
        inner join employees b on b.manager_id = a.employee_id
)

select * from cte where employee_id != 1;