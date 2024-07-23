-- https://leetcode.com/problems/consecutive-transactions-with-increasing-amounts/

with cte as (
    select
        a.*,
        case
        when datediff(a.transaction_date, lag(a.transaction_date, 1) over win) > 1 then 1
        else 0
        end as not_consecutive,
        case
        when a.amount <= lag(a.amount, 1) over win then 1 else 0
        end as not_increasing
    from transactions a
    window win as (partition by a.customer_id order by a.transaction_date)
),
grpd as (
    select
        a.*,
        sum(a.not_consecutive + a.not_increasing) over win as grp
    from cte a
    window win as (partition by a.customer_id order by a.transaction_date)
)

select
    a.customer_id,
    min(a.transaction_date) as consecutive_start,
    max(a.transaction_date) as consecutive_end
from grpd a
group by a.customer_id, a.grp
having count(1) >= 3;