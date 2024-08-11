-- https://leetcode.com/problems/page-recommendations-ii/

with flc as (
    select
        a.user_id,
        b.page_id,
        count(1) as friends_likes
    from (
        select user1_id as user_id, user2_id as friend_id from friendship union
        select user2_id as user_id, user1_id as friend_id from friendship
    ) a
        inner join likes b on a.friend_id = b.user_id
    group by 1, 2
)

select a.*
from flc a
    left join likes b on a.user_id = b.user_id and a.page_id = b.page_id
where b.user_id is null;
