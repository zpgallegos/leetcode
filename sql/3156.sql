-- https://leetcode.com/problems/employee-task-duration-and-concurrent-tasks/


with duration as (
    select
        employee_id,
        task_id,
        sum(timestampdiff(second, start_time, end_time)) as task_duration
    from tasks
    group by 
        employee_id,
        task_id
), overlaps as (
    select
        a.employee_id,
        a.task_id,
        sum(
            timestampdiff(second, b.start_time, if(a.end_time < b.end_time, a.end_time, b.end_time))
        ) as task_overlap
    from tasks a join tasks b
    where 
        a.employee_id = b.employee_id and
        b.start_time > a.start_time and
        b.start_time < a.end_time
    group by
        a.employee_id,
        a.task_id
), net as (
    select
        a.employee_id,
        floor(sum(a.task_duration - coalesce(b.task_overlap, 0)) / (60 * 60)) as total_task_hours
    from duration a
        left join overlaps b on a.employee_id = b.employee_id and a.task_id = b.task_id
    group by a.employee_id
), concurrent as (
    select
        sub.employee_id,
        max(sub.total_concurrent) as max_concurrent_tasks
    from (
        select employee_id, task_id, count(1) + 1 as total_concurrent
        from overlaps
        group by employee_id, task_id
    ) sub
    group by
        sub.employee_id
)

select a.employee_id, a.total_task_hours, coalesce(b.max_concurrent_tasks, 1) as max_concurrent_tasks
from net a left join concurrent b on a.employee_id = b.employee_id
order by a.employee_id;