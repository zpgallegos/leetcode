-- https://leetcode.com/problems/primary-department-for-each-employee/description/

with cte as (
    select
        a.*,
        count(1) over win as cnt
    from employee a
    window win as (partition by a.employee_id)
)

select employee_id, department_id
from cte
where cnt = 1 or primary_flag = 'Y';