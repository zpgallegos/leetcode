-- https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/

with recursive expected as (
    select task_id, 1 as subtask_id
    from tasks

    union

    select a.task_id, a.subtask_id + 1 as subtask_id
    from expected a
        inner join tasks b on a.task_id = b.task_id
    where a.subtask_id < b.subtasks_count
)

select a.*
from expected a
    left join executed b on a.task_id = b.task_id and a.subtask_id = b.subtask_id
where b.subtask_id is null;