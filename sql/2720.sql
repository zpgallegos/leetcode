-- https://leetcode.com/problems/popularity-percentage/description/

with cte as (
    select user1, user2 as friend from friends union
    select user2 as user1, user1 as friend from friends
)

select
    a.user1,
    round((count(1)::numeric / (select count(distinct user1)::numeric from cte)) * 100, 2) as percentage_popularity
from cte a
group by 1
order by 1;