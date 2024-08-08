-- https://leetcode.com/problems/ceo-subordinate-hierarchy/description/


with recursive ceo as (
    select
        a.employee_id as ceo_id,
        a.salary as ceo_salary
    from employees a
    where manager_id is null
),
cte as (
    select
        a.employee_id as subordinate_id,
        a.employee_name as subordinate_name,
        1 as hierarchy_level,
        a.salary,
        a.salary - b.ceo_salary as salary_difference
    from employees a
        inner join ceo b on a.manager_id = b.ceo_id

    union all

    select
        a.employee_id as subordinate_id,
        a.employee_name as subordinate_name,
        b.hierarchy_level + 1 as hierarchy_level,
        a.salary,
        b.salary_difference + (a.salary - b.salary) as salary_difference    
    from employees a
        inner join cte b on a.manager_id = b.subordinate_id
)

select
    a.subordinate_id,
    a.subordinate_name,
    a.hierarchy_level,
    a.salary_difference
from cte a
order by 3, 1;

