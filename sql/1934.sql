-- https://leetcode.com/problems/confirmation-rate/

with rates as (
    select
        a.user_id,
        round(avg(if(a.action = 'confirmed', 1, 0)), 2) as confirmation_rate
    from confirmations a
    group by 1
)

select * from rates

union

select a.user_id, 0 as confirmation_rate
from signups a
where a.user_id not in(select user_id from rates);
