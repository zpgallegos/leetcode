-- https://leetcode.com/problems/all-people-report-to-the-given-manager/

with recursive cte as (
    select employee_id, 1 as n
    from Employees
    where manager_id = 1 and employee_id != 1

    union all

    select a.employee_id, b.n + 1 as n
    from Employees a
        inner join cte b on a.manager_id = b.employee_id
    where b.n + 1 <= 3
)

select employee_id from cte;