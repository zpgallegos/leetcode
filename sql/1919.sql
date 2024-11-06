-- https://leetcode.com/problems/leetcodify-similar-friends/description/


select distinct
    a.user_id as user1_id,
    b.user2_id
from listens a
    inner join friendship b on a.user_id = b.user1_id
    inner join listens c on 
        1=1
        and b.user2_id = c.user_id
        and a.song_id = c.song_id
        and a.day = c.day
group by a.user_id, b.user2_id, a.day
having count(distinct a.song_id) >= 3;