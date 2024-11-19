-- https://leetcode.com/problems/average-time-of-process-per-machine/description/


select
    a.machine_id,
    round(avg(b.timestamp - a.timestamp)::numeric, 3) as processing_time
from activity a
    inner join activity b on a.machine_id = b.machine_id and a.process_id = b.process_id
where
    1=1
    and a.activity_type = 'start'
    and b.activity_type = 'end'
group by 1