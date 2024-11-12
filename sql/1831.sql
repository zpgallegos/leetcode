-- https://leetcode.com/problems/maximum-transaction-each-day/

with cte as (
    select
        day::date as dt,
        max(amount) as mx
    from transactions
    group by 1
)

select a.transaction_id
from transactions a
    inner join cte b on a.day::date = b.dt and a.amount = b.mx
order by 1;

-- or...

with cte as (
    select
        a.*,
        rank() over win as rnk
    from transactions a
    window win as (partition by a.day::date order by a.amount desc)
)

select transaction_id from cte where rnk = 1 order by 1;