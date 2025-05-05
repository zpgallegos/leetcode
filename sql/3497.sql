-- https://leetcode.com/problems/analyze-subscription-conversion/

with

cte as (
    select
        *,
        activity_type = 'free_trial' as is_free,
        lead(activity_type) over win = 'paid' as next_is_paid
    from useractivity a
    window win as (partition by user_id order by activity_date)
)

select
    user_id,
    round(avg(case when activity_type = 'free_trial' then activity_duration end), 2) as trial_avg_duration,
    round(avg(case when activity_type = 'paid' then activity_duration end), 2) as paid_avg_duration

from useractivity

where user_id in (
    select distinct user_id
    from cte
    where is_free and next_is_paid
)

group by 1
order by 1;