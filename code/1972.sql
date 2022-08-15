-- https://leetcode.com/problems/first-and-last-call-on-the-same-day/


with all_calls as (
    select 
        *, 
        date_format(call_time, '%Y-%m-%d') as call_day
    from Calls
    
    union all
    
    select 
        recipient_id as caller_id,
        caller_id as recipient_id,
        call_time,
        date_format(call_time, '%Y-%m-%d') as call_day
    from Calls
), ranked as (
    select
        *,
        first_value(recipient_id) over win as fst,
        last_value(recipient_id) over win as lst
    from all_calls
    window win as (
        partition by caller_id, call_day 
        order by call_time 
        rows between unbounded preceding and unbounded following)
)

select distinct caller_id as user_id
from ranked
where fst = lst;