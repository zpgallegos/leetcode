-- https://leetcode.com/problems/leetcodify-friends-recommendations/description/


with tbl as (
    select distinct
        a.user_id as user1_id,
        b.user_id as user2_id
    from listens a
        inner join listens b on a.user_id < b.user_id and a.song_id = b.song_id and a.day = b.day
    group by
        a.user_id,
        b.user_id,
        a.day
    having count(distinct a.song_id) >= 3
),
res as (
    select 
        a.user1_id as user_id,
        a.user2_id as recommended_id
    from tbl a
        left join friendship b on a.user1_id = b.user1_id and a.user2_id = b.user2_id
    where b.user1_id is null
)

select * from res union
select recommended_id as user_id, user_id as recommended_id from res;