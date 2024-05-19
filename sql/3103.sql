-- https://leetcode.com/problems/find-trending-hashtags-ii/description/


with matches as (
    select
        hashtag,
        count(1) as count
    from (
        select regexp_matches(tweet, '(#\w+)', 'g') as hashtag
        from tweets
    ) sub
    group by hashtag
), cte as (
    select *, row_number() over(order by count desc, hashtag desc) as rn
    from matches
)

select hashtag, count
from cte
where rn <= 3;