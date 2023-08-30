-- https://leetcode.com/problems/biggest-window-between-visits/


with diff as (
    select
        user_id,
        datediff(visit_date, lag(visit_date, 1) over win) as df
    from
        UserVisits window win as (
            partition by user_id
            order by
                visit_date
        )
),
cur as (
    select
        user_id,
        datediff('2021-01-01', max(visit_date)) as df
    from
        UserVisits
    group by
        user_id
)

select user_id, max(df) as biggest_window
from (
    select * from diff union
    select * from cur
) s
group by user_id;

-- using lead, better cause you can use the null to do today in one query

with diff as (
    select
        user_id,
        datediff(
            coalesce(lead(visit_date, 1) over win, '2021-01-01'),
            visit_date
        ) as df
    from UserVisits
    window win as (partition by user_id order by visit_date)
)

select user_id, max(df) as biggest_window
from diff
group by user_id;