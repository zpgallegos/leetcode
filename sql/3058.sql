-- https://leetcode.com/problems/friends-with-no-mutual-friends/description/

with cte as (
    select user_id1 as main, user_id2 as friend from friends union
    select user_id2 as main, user_id1 as friend from friends
),
mutual as (
    select
        t1.main,
        t1.friend,
        t2.friend as mutual
    from cte t1
        inner join cte t2 on t1.friend = t2.main and t2.friend <> t1.main
        inner join cte t3 on t2.friend = t3.main and t3.friend = t1.main
)

select a.*
from friends a 
    left join mutual b on a.user_id1 = b.main and a.user_id2 = b.friend
where b.main is null
order by a.user_id1, a.user_id2;
