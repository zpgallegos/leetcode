-- https://leetcode.com/problems/leetcodify-similar-friends/

select distinct
    a.user_id as user1_id,
    b.user_id as user2_id

from listens a
    inner join listens b on a.day = b.day and a.song_id = b.song_id
    inner join friendship c on a.user_id = c.user1_id and b.user_id = c.user2_id

group by a.user_id, b.user_id, a.day

having count(distinct a.song_id) >= 3;