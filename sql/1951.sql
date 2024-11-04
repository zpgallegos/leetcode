-- https://leetcode.com/problems/all-the-pairs-with-the-maximum-number-of-common-followers/description/


with cte as (
    select
        a.user_id as user1_id,
        b.user_id as user2_id,
        count(1) as cnt
    from relations a
        inner join relations b on a.follower_id = b.follower_id
    where a.user_id < b.user_id
    group by 1, 2
)

select user1_id, user2_id
from cte
where cnt = (select max(cnt) from cte);