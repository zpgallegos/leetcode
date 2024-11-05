-- https://leetcode.com/problems/strong-friendship/description/

with cte as (
    select * from friendship union
    select user2_id as user1_id, user1_id as user2_id from friendship
),
cnts as (
    select
        a.user1_id as user1_id,
        b.user1_id as user2_id,
        count(1) as common_friend
    from cte a cross join cte b
    where
        1=1
        and a.user1_id < b.user1_id
        and a.user2_id = b.user2_id
    group by 1, 2
)

select a.* 
from cnts a 
    -- cnts only counts common friends
    -- this join is to make sure the results are limited to people who are friends
    inner join friendship b on a.user1_id = b.user1_id and a.user2_id = b.user2_id
where common_friend >= 3;