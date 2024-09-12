-- https://leetcode.com/problems/find-active-users/description/

with cte as (
    select
        a.user_id,
        a.created_at - lag(a.created_at, 1) over win as diff
    from users a
    window win as (partition by a.user_id order by a.created_at)
)

select distinct user_id
from cte
where diff <= 7
order by 1;