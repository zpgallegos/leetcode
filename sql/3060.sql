-- https://leetcode.com/problems/user-activities-within-time-bounds/description/


with cte as (
    select
        a.*,
        lag(a.session_end) over win as last_session_end
    from sessions a
    window win as (partition by a.user_id, a.session_type order by a.session_start)
)

select distinct user_id
from cte
where
    1=1
    and last_session_end is not null 
    and extract(epoch from (session_start - last_session_end)) / (60 * 60) <= 12;

-- or...

select distinct a.user_id 
from sessions a cross join sessions b
where
    a.user_id = b.user_id and
    a.session_id <> b.session_id and
    a.session_start > b.session_start and
    a.session_type = b.session_type and
    datediff(hour, b.session_end, a.session_start) <= 12
order by a.user_id;
