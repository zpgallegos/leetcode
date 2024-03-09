-- https://leetcode.com/problems/employees-project-allocation/description/


with cte as (
    select
        a.*,
        b.name,
        avg(a.workload) over(partition by b.team) as team_avg
    from project a
        inner join employees b on a.employee_id = b.employee_id
)

select
    employee_id,
    project_id,
    name as employee_name,
    workload as project_workload
from cte
where workload > team_avg
order by employee_id, project_id;