-- https://leetcode.com/problems/find-trending-hashtags-ii/

with cte as (
    select regexp_matches(tweet, '#\w+', 'g') as hashtag
    from tweets
),
tabd as (
    select
        s.*,
        row_number() over win as rn
    from (
        select hashtag, count(1) as count
        from cte
        group by 1
    ) s
    window win as (order by s.count desc, s.hashtag desc)
)

select a.hashtag, a.count
from tabd a
where a.rn <= 3
order by 2 desc, 1 desc;


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