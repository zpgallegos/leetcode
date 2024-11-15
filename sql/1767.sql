-- https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/description/


with recursive cte as (
    select a.task_id, 1 as subtask_id
    from tasks a

    union all

    select a.task_id, a.subtask_id + 1
    from cte a
        inner join tasks b on a.task_id = b.task_id
    where a.subtask_id + 1 <= b.subtasks_count
)

select *
from cte
where (task_id, subtask_id) not in(select * from executed);