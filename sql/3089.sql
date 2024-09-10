-- https://leetcode.com/problems/find-bursty-behavior/description/


with feb as (
    select a.*
    from posts a
    where a.post_date between '2024-02-01' and  '2024-02-28'
),
cte as (
    select
        a.*,
        count(1) over win as curr_7day_posts
    from feb a
    window win as (
        partition by a.user_id
        order by a.post_date
        range between interval 6 day preceding and current row
    )
),
mxs as (
    select user_id, max(curr_7day_posts) as max_7day_posts
    from cte
    group by 1
),
avgs as (
    select user_id, count(1) / 4 as avg_weekly_posts
    from feb
    group by 1
)

select
    a.user_id,
    b.max_7day_posts,
    a.avg_weekly_posts
from avgs a
    inner join mxs b on a.user_id = b.user_id
where b.max_7day_posts >= 2 * a.avg_weekly_posts
order by 1;

-- without the window function, postgres doesn't support it

with feb as (
    select a.*
    from posts a
    where a.post_date between '2024-02-01' and  '2024-02-28'
),
mxs as (
    select
        s.user_id,
        max(s.curr) as max_7day_posts
    from (
        select
            a.user_id,
            a.post_id,
            a.post_date,
            count(1) as curr
        from feb a
            inner join feb b on a.user_id = b.user_id
        where b.post_date between a.post_date - interval '6 day' and a.post_date
        group by 1, 2, 3
    ) s
    group by 1
),
avgs as (
    select user_id, count(1)::float / 4 as avg_weekly_posts
    from feb
    group by 1
)

select
    a.user_id,
    b.max_7day_posts,
    a.avg_weekly_posts
from avgs a
    inner join mxs b on a.user_id = b.user_id
where b.max_7day_posts >= 2 * a.avg_weekly_posts
order by 1;
