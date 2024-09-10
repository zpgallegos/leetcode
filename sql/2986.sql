-- https://leetcode.com/problems/find-third-transaction/description/


with cte as (
    select
        a.*,
        lag(a.spend, 1) over win as lag1,
        lag(a.spend, 2) over win as lag2,
        row_number() over win as rn
    from transactions a
    window win as (partition by a.user_id order by a.transaction_date)
)

select
    a.user_id,
    a.spend as third_transaction_spend,
    a.transaction_date as third_transaction_date
from cte a
where
    1=1
    and a.rn = 3
    -- lol
    and a.spend > a.lag1 
    and a.spend > a.lag2
order by 1;