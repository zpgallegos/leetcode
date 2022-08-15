-- https://leetcode.com/problems/page-recommendations/



select sub.*
from (
    select distinct page_id as recommended_page
    from Likes
    where user_id in(
        select user2_id
        from Friendship
        where user1_id = 1
        union
        select user1_id
        from Friendship
        where user2_id = 1
    )
) sub left join (
    select page_id from Likes where user_id = 1
) sub2 on sub.recommended_page = sub2.page_id
where sub2.page_id is null;
    