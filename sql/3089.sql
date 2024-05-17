-- https://leetcode.com/problems/find-bursty-behavior/description/


with sub as (
    select * from posts where post_date >= '2024-02-01' and post_date <= '2024-02-28'
), avgs as (
    select user_id, count(1) / 4 as avg_weekly_posts
    from sub
    group by user_id
), mxs as (
    select
        user_id,
        count(1) over(partition by user_id order by post_date range between interval 6 Day preceding and current row) as user_weekly_post
    from sub
), cte as (
    select
        s.user_id,
        s.max_7day_posts,
        a.avg_weekly_posts
    from (
        select user_id, max(user_weekly_post) as max_7day_posts
        from mxs
        group by user_id
    ) s inner join avgs a on s.user_id = a.user_id
)

select *
from cte
where max_7day_posts >= avg_weekly_posts * 2
order by user_id;
