-- https://leetcode.com/problems/consecutive-transactions-with-increasing-amounts/

with cte as (
    select
        a.*,
        if(
            a.amount <= lag(a.amount, 1) over win or
            date_sub(a.transaction_date, interval 1 day) != lag(a.transaction_date, 1) over win,
            1, 0
        ) as incr
    from transactions a
    window win as (partition by a.customer_id order by a.transaction_date)
),
grpd as (
    select
        a.*,
        sum(a.incr) over win as grp
    from cte a
    window win as (
        partition by a.customer_id order by a.transaction_date
        rows between unbounded preceding and current row
    )
)

select
    a.customer_id,
    min(a.transaction_date) as consecutive_start,
    max(a.transaction_date) as consecutive_end
from grpd a
group by a.customer_id, a.grp
having count(1) >= 3
order by 1;
