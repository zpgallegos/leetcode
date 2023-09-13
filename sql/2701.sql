-- https://leetcode.com/problems/consecutive-transactions-with-increasing-amounts/

with cte as (
    select *,
        if(
            datediff(transaction_date, lag(transaction_date) over win) != 1 or
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
