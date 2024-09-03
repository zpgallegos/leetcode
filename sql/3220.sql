-- https://leetcode.com/problems/odd-and-even-transactions/

with cte as (
    select
        a.*,
        if(a.amount % 2 = 0, true, false) as is_even
    from transactions a
)

select
    a.transaction_date,
    sum(case when a.is_even then 0 else a.amount end) as odd_sum,
    sum(case when a.is_even then a.amount else 0 end) as even_sum
from cte a
group by 1
order by 1;
