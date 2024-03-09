-- https://leetcode.com/problems/viewers-turned-streamers/description/

with cte as (
    select *, row_number() over(partition by user_id order by session_start) as rw
    from sessions
), res as (
    select
        user_id,
        count(1) as sessions_count
    from sessions
    where
        user_id in(select distinct user_id from cte where rw = 1 and session_type = 'Viewer') and
        session_type = 'Streamer'
    group by user_id
)

select *
from res
order by sessions_count desc, user_id desc;