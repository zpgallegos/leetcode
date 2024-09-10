-- https://leetcode.com/problems/rolling-average-steps/description/

with tabd as (
    select
        a.user_id,
        a.steps_date,
        sum(a.steps_count) as steps
    from steps a
    group by 1, 2
),
rolling as (
    select
        a.user_id,
        a.steps_date,
        count(a.steps_date) over win as ncalc,
        round(avg(a.steps) over win, 2) as rolling_average
    from tabd a
    window win as (
        partition by a.user_id 
        order by a.steps_date
        range between interval 2 days preceding and current row
    )
)

select user_id, steps_date, rolling_average
from rolling
where ncalc = 3
order by 1, 2;


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