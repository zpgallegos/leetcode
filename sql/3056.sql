-- https://leetcode.com/problems/snaps-analysis/description/

with tm as (
    select
        b.age_bucket,
        a.activity_type,
        sum(a.time_spent) as activity_time

    from activities a
        inner join age b on a.user_id = b.user_id

    group by b.age_bucket, a.activity_type
), cte as (
    select
        a.age_bucket,
        a.activity_type,
        round(100 * (a.activity_time / b.total_time), 2) as time_prop
    from tm a
        inner join (
            select age_bucket, sum(activity_time) as total_time
            from tm
            group by age_bucket
        ) b on a.age_bucket = b.age_bucket
)

select
    age_bucket,
    sum(case when activity_type = 'send' then time_prop else 0 end) as send_perc,
    sum(case when activity_type = 'open' then time_prop else 0 end) as open_perc
from cte
group by age_bucket;