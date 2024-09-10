-- https://leetcode.com/problems/viewers-turned-streamers/description/

with cte as (
    select
        a.*,
        row_number() over win as rn
    from sessions a
    window win as (partition by a.user_id order by a.session_start)
),
incl as (
    select distinct user_id
    from cte
    where rn = 1 and session_type = 'Viewer'
)

select
    a.user_id,
    count(1) as sessions_count
from sessions a
where 
    1=1
    and a.user_id in(select * from incl)
    and a.session_type = 'Streamer'
group by 1
order by 2 desc, 1 desc;