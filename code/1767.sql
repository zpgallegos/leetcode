-- https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/

with recursive cte as (
    select task_id, 1 as subtask_id
    from Tasks

    union

    select
        b.task_id,
        b.subtask_id + 1 as subtask_id
    from Tasks a inner join cte b on a.task_id = b.task_id
    where b.subtask_id + 1 <= a.subtasks_count
)

select * from cte where (task_id, subtask_id) not in(select * from Executed);
