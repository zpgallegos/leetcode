-- https://leetcode.com/problems/users-that-actively-request-confirmation-messages/

with cte as (
    select
        *,
        time_stamp - lag(time_stamp) over(partition by user_id order by time_stamp) as diff

    from confirmations
)

select distinct user_id
from cte
where diff <= 1000000;