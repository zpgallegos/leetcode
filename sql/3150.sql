-- https://leetcode.com/problems/invalid-tweets-ii/

with cte as (
    select 
        a.tweet_id,
        concat(' ', a.content) as content,
        length(a.content) as n 
    from tweets a
)

select tweet_id
from cte
where
    n > 140
    or n - length(replace(content, ' @', '')) >= 6
    or n - length(replace(content, ' #', '')) >= 6
order by 1;