-- https://leetcode.com/problems/find-third-transaction/

with cte as (
    select
        *,
        row_number() over (partition by user_id order by transaction_date) as rw,
        lag(spend, 1) over (partition by user_id order by transaction_date) as prev1,
        lag(spend, 2) over (partition by user_id order by transaction_date) as prev2
    from transactions
)

select
    user_id,
    spend as third_transaction_spend,
    transaction_date as third_transaction_date
from cte
where rw = 3 and spend > prev1 and spend > prev2
order by user_id;
