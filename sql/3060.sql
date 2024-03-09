-- https://leetcode.com/problems/user-activities-within-time-bounds/description/

-- LOL this problem sucks

select distinct a.user_id 
from sessions a cross join sessions b
where
    a.user_id = b.user_id and
    a.session_id <> b.session_id and
    a.session_start > b.session_start and
    a.session_type = b.session_type and
    datediff(hour, b.session_end, a.session_start) <= 12
order by a.user_id;
