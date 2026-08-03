-- https://leetcode.com/problems/find-zombie-sessions/

with agg as (
    select
        session_id,
        user_id,
        extract(epoch from max(event_timestamp) - min(event_timestamp)) / 60 as session_duration_minutes,
        count(1) filter(where event_type = 'click') as click_count,
        count(1) filter(where event_type = 'scroll') as scroll_count,
        count(1) filter(where event_type = 'purchase') as purchase_count
    from app_events
    group by 1, 2
)    

select
    session_id,
    user_id,
    session_duration_minutes,
    scroll_count
from agg
where
    session_duration_minutes > 30
    and scroll_count >= 5
    and click_count::numeric / scroll_count < 0.20
    and purchase_count = 0
order by 4 desc, 1;