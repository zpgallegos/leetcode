-- https://leetcode.com/problems/find-trending-hashtags/description/


with matches as (
    select 
        regexp_matches(tweet, '#\w+') as hashtag,
        count(1) as hashtag_count
    from tweets
    group by 1
),
cte as (
    select a.*, row_number() over win as rn
    from matches a
    window win as (order by a.hashtag_count desc, a.hashtag desc)
)

select hashtag, hashtag_count
from cte
where rn <= 3;
