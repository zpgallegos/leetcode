-- https://leetcode.com/problems/popularity-percentage/

with cte as (
    select * from friends union
    select user2 as user1, user1 as user2 from friends
), cnts as (
    select user1, count(distinct user2) as frnds
    from cte
    group by user1
)

select
    user1,
    round((frnds / (select count(distinct user1) from cnts)) * 100, 2) as percentage_popularity
from cnts
order by user1;