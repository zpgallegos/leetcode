-- https://leetcode.com/problems/page-recommendations-ii/description/


with friends as (
    select * from friendship union
    select user2_id as user1_id, user1_id as user2_id from friendship
),
agg as (
    select
        a.user1_id as user_id,
        b.page_id,
        count(distinct a.user2_id) as friends_likes
    from friends a
        inner join likes b on a.user2_id = b.user_id
    group by 1, 2
)

select a.*
from agg a
    left join likes b on a.user_id = b.user_id and a.page_id = b.page_id
where b.user_id is null;