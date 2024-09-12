-- https://leetcode.com/problems/customers-with-maximum-number-of-transactions-on-consecutive-days/ 

with lagged as (
    select
        a.*,
        lag(a.transaction_date, 1) over win as last_dt
    from transactions a
    window win as (partition by a.customer_id order by a.transaction_date)
),
cte as (
    select
        a.*,
        case
        when a.last_dt is null or a.transaction_date - a.last_dt != 1 then 1
        else 0
        end as incr
    from lagged a
),
grpd as (
    select
        a.*,
        sum(a.incr) over win as grp
    from cte a
    window win as (
        partition by a.customer_id 
        order by a.transaction_date
        rows between unbounded preceding and current row
    )
),
aggd as (
    select customer_id, grp, count(1) as n
    from grpd
    group by 1, 2
)

select customer_id
from aggd
where n = (select max(n) from aggd)
order by 1;