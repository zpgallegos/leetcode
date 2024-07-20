-- https://leetcode.com/problems/odd-and-even-transactions/

with src as (
    select
        a.*,
        if(a.amount % 2 = 0, 1, 0) as is_even
    from transactions a
)

select
    a.transaction_date,
    sum(case when a.is_even = 0 then a.amount else 0 end) as odd_sum,
    sum(case when a.is_even = 1 then a.amount else 0 end) as even_sum
from src a
group by a.transaction_date
order by a.transaction_date;
