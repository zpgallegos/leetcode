-- https://leetcode.com/problems/first-and-last-call-on-the-same-day/

with cte as (
    select 
        caller_id as user_id, 
        recipient_id as recip_id,
        date(call_time) as call_day,
        call_time 
    from calls

    union all

    select 
        recipient_id as user_id, 
        caller_id as recip_id,
        date(call_time) as call_day,
        call_time 
    from calls
),
ordered as (
    select
        a.user_id,
        first_value(a.recip_id) over win as frst,
        last_value(a.recip_id) over win as lst
    from cte a
    window win as (
        partition by a.user_id, a.call_day 
        order by a.call_time
        rows between unbounded preceding and unbounded following
    )
)

select distinct user_id
from ordered
where frst = lst;
