-- https://leetcode.com/problems/users-with-two-purchases-within-seven-days/description/

with cte as (
    select
        a.*,
        a.purchase_date - (lag(a.purchase_date, 1) over win) as diff
    from purchases a
    window win as (partition by a.user_id order by a.purchase_date)
)

select distinct user_id
from cte
where diff <= 7
order by 1;