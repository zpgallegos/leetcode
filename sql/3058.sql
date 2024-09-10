-- https://leetcode.com/problems/friends-with-no-mutual-friends/description/


with all_friends as (
    select user_id1 as user, user_id2 as friend from friends union
    select user_id2 as user, user_id1 as friend from friends
),
cte as (
    select a.*
    from all_friends a
        inner join all_friends b on a.friend = b.user and b.friend != a.user
        inner join all_friends c on a.user = c.user and b.friend = c.friend
)

select a.*
from friends a
    left join cte b on a.user_id1 = b.user and a.user_id2 = b.friend
where b.user is null
order by 1, 2;