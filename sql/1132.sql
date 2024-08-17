-- https://leetcode.com/problems/reported-posts-ii/

with spam as (
    select distinct
        a.post_id,
        a.action_date
    from actions a
    where a.extra = 'spam'
),
daily as (
    select
        a.action_date,
        avg(if(b.remove_date is not null, 1, 0)) as prop
    from spam a
        left join removals b on a.post_id = b.post_id
    group by 1
)

select round(avg(a.prop) * 100, 2) as average_daily_percent
from daily a;