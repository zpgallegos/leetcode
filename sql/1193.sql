-- https://leetcode.com/problems/monthly-transactions-i/description/

with cte as (
    select
        a.*,
        date_format(a.trans_date, '%Y-%m') as month,
        if(a.state = 'approved', true, false) as is_approved
    from transactions a
)

select
    a.month,
    a.country,
    count(1) as trans_count,
    sum(if(a.is_approved, 1, 0)) as approved_count,
    sum(a.amount) as trans_total_amount,
    sum(if(a.is_approved, a.amount, 0)) as approved_total_amount
from cte a
group by 1, 2;