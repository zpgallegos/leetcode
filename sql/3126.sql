-- https://leetcode.com/problems/server-utilization-time/description/



with stg as (
    select
        *,
        lag(session_status, 1) over w as last_status,
        lag(status_time, 1) over w as last_time
    from servers
    window w as (partition by server_id order by status_time)
), cte as (
    select
        *,
        case
        when session_status = 'stop' and last_status = 'start' then
            extract(EPOCH from (status_time - last_time))
        else 0
        end as diff_seconds
    from stg
)

select sum(diff_seconds)::int / 86400 as total_uptime_days
from cte;