-- https://leetcode.com/problems/users-that-actively-request-confirmation-messages/description/

with cte as (
    select
        a.user_id,
        extract(epoch from a.time_stamp - lag(a.time_stamp, 1) over win) / (60 * 60) as dif
    from confirmations a
    window win as (partition by a.user_id order by a.time_stamp)
)

select distinct user_id
from cte
where dif <= 24;