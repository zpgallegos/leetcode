-- https://leetcode.com/problems/server-utilization-time/description/

with cte as (
    select
        a.*,
        lag(a.status_time, 1) over win as last_time
    from servers a
    window win as (partition by a.server_id order by a.status_time)
)

select floor(sum(extract(epoch from (a.status_time - a.last_time))) / (60 * 60 * 24)) as total_uptime_days
from cte a
where a.session_status = 'stop';


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
