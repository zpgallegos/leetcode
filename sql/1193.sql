-- https://leetcode.com/problems/monthly-transactions-i/description/

with cte as (
    select *, format(trans_date, 'yyyy-MM') as month
    from transactions
)

select
    month,
    country,
    count(1) as trans_count,
    count(case when state = 'approved' then 1 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from cte
group by month, country;