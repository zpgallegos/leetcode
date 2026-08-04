-- https://leetcode.com/problems/find-users-with-persistent-behavior-patterns/description/

with cte as (
    select
        *,
        case
            when
                action_date = lag(action_date) over win + interval '1 day'
                and action = lag(action) over win
            then 0
            else 1
        end as incr
    from activity
    window win as (partition by user_id order by action_date)
),

grpd as (
    select
        user_id,
        action,
        action_date,
        sum(incr) over win as grp
    from cte
    window win as (partition by user_id order by action_date)
)

select
    user_id,
    action,
    count(1) as streak_length,
    min(action_date) as start_date,
    max(action_date) as end_date
from grpd
group by user_id, action, grp
having count(1) >= 5
order by 3 desc, 1;