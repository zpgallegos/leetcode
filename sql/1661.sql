-- https://leetcode.com/problems/average-time-of-process-per-machine/

with cte as (
    select
        a.machine_id,
        a.process_id,
        a.timestamp as start_time,
        timestamp as end_time
    from activity a
        inner join activity b on a.machine_id = b.machine_id and a.process_id = b.process_id
    where 
        a.activity_type = 'start' and 
        b.activity_type = 'end'
)

select machine_id, round(avg(end_time - start_time), 3) as processing_time
from cte
group by machine_id;