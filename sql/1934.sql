-- https://leetcode.com/problems/confirmation-rate/description/

with tbl as (
    select
        a.user_id,
        round(avg(case when a.action = 'confirmed' then 1 else 0 end), 2) as confirmation_rate
    from confirmations a
    group by 1
)

select
    a.user_id,
    coalesce(b.confirmation_rate, 0) as confirmation_rate
from signups a
    left join tbl b on a.user_id = b.user_id;