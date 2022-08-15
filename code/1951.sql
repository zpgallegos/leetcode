-- https://leetcode.com/problems/all-the-pairs-with-the-maximum-number-of-common-followers/


-- works but is too slow

with common as (
    select 
        a.user_id as user1_id, 
        b.user_id as user2_id,
        sum(a.follower_id = b.follower_id) as cmn
    from Relations a cross join Relations b
    where a.user_id < b.user_id
    group by a.user_id, b.user_id
)

select user1_id, user2_id
from common
where cmn = (select max(cmn) from common);

-- 

with common as (
    select
        *,
        rank() over(order by cmn desc) as rnk
    from (
        select
            a.user_id as user1_id,
            b.user_id as user2_id,
            count(1) as cmn
        from Relations a
            inner join Relations b on a.follower_id = b.follower_id
        where a.user_id < b.user_id
        group by a.user_id, b.user_id
    ) s
)

select user1_id, user2_id
from common
where rnk = 1;