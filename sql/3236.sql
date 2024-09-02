-- https://leetcode.com/problems/ceo-subordinate-hierarchy/


with recursive cte as (
    select
        a.employee_id as subordinate_id,
        a.employee_name as subordinate_name,
        1 as hierarchy_level,
        a.salary,
        a.salary - b.salary as salary_difference
    from employees a
        inner join employees b on a.manager_id = b.employee_id
    where b.manager_id is null

    union

    select
        a.employee_id as subordinate_id,
        a.employee_name as subordinate_name,
        b.hierarchy_level + 1 as hierarchy_level,
        a.salary,
        b.salary_difference + a.salary - b.salary as salary_difference
    from employees a
        inner join cte b on a.manager_id = b.subordinate_id
)

select
    subordinate_id,
    subordinate_name,
    hierarchy_level,
    salary_difference
from cte
order by 3, 1;
