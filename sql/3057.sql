-- https://leetcode.com/problems/employees-project-allocation/description/


with cte as (
    select
        b.*,
        a.name,
        a.team
    from employees a
        inner join project b on a.employee_id = b.employee_id
)

select
    a.employee_id,
    a.project_id,
    a.name as employee_name,
    a.workload as project_workload
from cte a
    inner join (
        select a.team, avg(a.workload) as team_avg_workload
        from cte a
        group by 1
    ) s on a.team = s.team
where a.workload > s.team_avg_workload
order by 1, 2;