-- https://leetcode.com/problems/leetcodify-similar-friends/description/

select distinct
    a.user1_id,
    a.user2_id

from friendship a
    inner join listens b on a.user1_id = b.user_id
    inner join listens c on 
        a.user2_id = c.user_id and 
        b.day = c.day and
        b.song_id = c.song_id

group by 
    a.user1_id,
    a.user2_id,
    b.day

having count(distinct b.song_id) >= 3;
