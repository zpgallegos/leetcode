-- https://leetcode.com/problems/customers-with-maximum-number-of-transactions-on-consecutive-days/

with cte as (
    select
        *,
        if(
            transaction_date - lag(transaction_date) over(partition by customer_id order by transaction_date) > 1, 1, 0
        ) as chg
    from transactions
), grpd as (
    select
        *,
        sum(chg) over(partition by customer_id order by transaction_date) as grp
    from cte
), cnts as (
    select customer_id, grp, count(1) as cnt
    from grpd
    group by customer_id, grp
)

select customer_id
from cnts
where cnt = (select max(cnt) from cnts)
order by customer_id;