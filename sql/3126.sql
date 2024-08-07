-- https://leetcode.com/problems/server-utilization-time/description/


with cte as (
    select
        a.server_id,
        a.status_time,
        a.session_status,
        coalesce(timestampdiff(second, lag(a.status_time, 1) over w, a.status_time), 0) as diff
    from servers a
    window w as (partition by a.server_id order by a.status_time)
)

select cast(floor(sum(diff) / 86400) as unsigned) as total_uptime_days
from cte
where session_status = 'stop'
