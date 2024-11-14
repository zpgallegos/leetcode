-- https://leetcode.com/problems/ad-free-sessions/description/


select distinct session_id
from playback a
where session_id not in(
    select distinct session_id
    from playback a
        inner join ads b on 
            1=1
            and a.customer_id = b.customer_id 
            and b.timestamp between a.start_time and a.end_time
)