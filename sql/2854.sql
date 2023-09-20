-- https://leetcode.com/problems/rolling-average-steps/

with cte as (
    select
        *,
        round(avg(steps_count) over win, 2) as rolling_average,
        datediff(steps_date, lag(steps_date, 2) over win) as diff_2day
    from steps
    window win as(
        partition by user_id 
        order by steps_date
        rows between 2 preceding and current row
    )
)

select user_id, steps_date, rolling_average
from cte
where diff_2day = 2
order by user_id, steps_date;