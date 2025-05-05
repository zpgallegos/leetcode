-- https://leetcode.com/problems/analyze-organization-hierarchy/description/


with recursive

cte as (
    select
        employee_id, 
        employee_name,
        manager_id,
        salary,
        1 as level
    from employees
    where manager_id is null

    union

    select
        a.employee_id, 
        a.employee_name,
        a.manager_id,
        a.salary,
        b.level + 1
    from employees a
    inner join cte b on a.manager_id = b.employee_id
),

res as (
    select
        a.employee_id,
        a.employee_name,
        a.level,
        a.salary,
        count(inr.employee_id) as team_size,
        a.salary + sum(coalesce(inr.salary, 0)) as budget
    
    from cte a
    left join lateral (
        with recursive this as (
            -- people who have this employee as a manager
            select employee_id, manager_id, salary
            from cte c
            where c.manager_id = a.employee_id

            union

            -- people who have those people as a manager
            select a.employee_id, a.manager_id, a.salary
            from cte a
            inner join this b on a.manager_id = b.employee_id
        )
        select * from this
    ) inr on true

    group by 1, 2, 3, 4
)

select employee_id, employee_name, level, team_size, budget
from res
order by level, budget desc, employee_name;