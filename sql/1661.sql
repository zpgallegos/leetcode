-- https://leetcode.com/problems/average-time-of-process-per-machine/description/

with cte as (
    select
        a.machine_id,
        a.process_id,
        b.timestamp - a.timestamp as duration
    from activity a
        inner join activity b on a.machine_id = b.machine_id and a.process_id = b.process_id
    where
        1=1
        and a.activity_type = 'start'
        and b.activity_type = 'end'
)

select machine_id, round(avg(duration), 3) as processing_time
from cte
group by 1;