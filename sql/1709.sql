-- https://leetcode.com/problems/biggest-window-between-visits/description/

with cte as (
    select
        a.user_id,
        coalesce(lead(a.visit_date, 1) over win, '2021-01-01'::date) - a.visit_date as dys
    from uservisits a
    window win as (partition by a.user_id order by a.visit_date)
)

select user_id, max(dys) as biggest_window
from cte
group by 1
order by 1;