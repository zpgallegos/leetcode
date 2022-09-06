-- https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/

with recursive cte as (
    select task_id, 1 as subtask_id
    from tasks

    union

    select tasks.task_id, cte.subtask_id + 1 as subtask_id
    from cte
        inner join tasks on cte.subtask_id + 1 <= tasks.subtasks_count
)

select c.*
from cte c
    left join executed s on c.task_id = s.task_id and c.subtask_id = s.subtask_id
where s.subtask_id is null;