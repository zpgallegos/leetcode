-- https://leetcode.com/problems/snaps-analysis/description/


with cte as (
    select
        b.age_bucket,
        a.activity_type,
        sum(a.time_spent) as activity_total
    from activities a
        inner join age b on a.user_id = b.user_id
    group by 1, 2
),
piv as (
    select
        a.age_bucket,
        coalesce(max(case when a.activity_type = 'send' then a.activity_total end), 0) as send_time,
        coalesce(max(case when a.activity_type = 'open' then a.activity_total end), 0) as open_time,
        sum(activity_total) as total_time
    from cte a
    group by 1
)

select
    age_bucket,
    round((send_time / total_time) * 100, 2) as send_perc,
    round((open_time / total_time) * 100, 2) as open_perc
from piv;