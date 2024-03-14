-- https://leetcode.com/problems/ad-free-sessions/


select distinct session_id 
from playback
where session_id not in (
    select session_id
    from playback a left join ads b on a.customer_id = b.customer_id
    where b.timestamp between a.start_time and a.end_time
);
