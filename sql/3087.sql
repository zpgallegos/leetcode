-- https://leetcode.com/problems/find-trending-hashtags/

with cte as (
    select *, substring(tweet from '#\w+') as hashtag
    from tweets
), cte1 as (
    select hashtag, count(*) as hashtag_count
    from cte
    group by hashtag
), cte2 as (
    select *, row_number() over(order by hashtag_count desc, hashtag desc) as rn
    from cte1
)

select hashtag, hashtag_count
from cte2
where rn <= 3;