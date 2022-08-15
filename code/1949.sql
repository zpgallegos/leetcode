-- https://leetcode.com/problems/strong-friendship/


with all_friends as (
    select user1_id as user, user2_id as friend
    from Friendship
    union
    select user2_id as user, user1_id as friend
    from Friendship
)


select a.user as user1_id, b.user as user2_id, count(1) as common_friend
from all_friends a inner join all_friends b on a.friend = b.friend
where a.user < b.user 
    -- have to add this to make sure the users that have the 3 users in common are friends,
    and (a.user, b.user) in (select * from all_friends)
group by a.user, b.user
having count(1) >= 3

-- alternatively...instead of using the in()
-- this seems slightly slower though...

select a.user1_id, a.user2_id, b.common_friend
from friendship a inner join (
    select a.user as user1_id, b.user as user2_id, count(1) as common_friend
    from all_friends a inner join all_friends b on a.friend = b.friend
    group by a.user, b.user
) b on a.user1_id = b.user1_id and a.user2_id = b.user2_id
where b.common_friend >= 3;