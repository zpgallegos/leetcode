-- https://leetcode.com/problems/maximum-transaction-each-day/


with ranked as (
    select
        transaction_id,
        rank() over(partition by day(a.day) order by amount desc) as rnk
    
    from Transactions a
)

select transaction_id
from ranked
where rnk = 1
order by transaction_id;