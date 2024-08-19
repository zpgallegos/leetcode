-- https://leetcode.com/problems/customers-with-maximum-number-of-transactions-on-consecutive-days/description/

with lagged as (
    select
        a.*,
        lag(a.transaction_date, 1) over(partition by a.customer_id order by a.transaction_date) as last_date
    from transactions a
),
incr as (
    select
        a.*,
        if(a.last_date is null or a.transaction_date - a.last_date > 1, 1, 0) as incr
    from lagged a
),
grpd as (
    select
        a.*,
        sum(a.incr) over(partition by a.customer_id order by a.transaction_date) as grp
    from incr a
),
cnts as (
    select a.customer_id, a.grp, count(1) as cnt
    from grpd a
    group by 1, 2
)

select a.customer_id
from cnts a
where a.cnt = (select max(cnt) from cnts)
order by 1;