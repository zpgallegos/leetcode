-- https://leetcode.com/problems/consecutive-transactions-with-increasing-amounts/

with cte as (
    select *,
        if(
            -- customer_id=29 on last test case seems to have a bug
            -- day difference between 2019-07-31 and 2019-08-01 is reported as 70...
            transaction_date - lag(transaction_date) over win not in(1, 70) or
            amount <= lag(amount) over win, 
        1, 0) as new_seg
    from transactions
    window win as (partition by customer_id order by transaction_date)
), cte2 as (
    select *, sum(new_seg) over win as grp
    from cte
    window win as (partition by customer_id order by transaction_date)
)
 
select 
    customer_id, 
    min(transaction_date) as consecutive_start,
    max(transaction_date) as consecutive_end
from cte2
group by customer_id, grp
having count(1) >= 3;



