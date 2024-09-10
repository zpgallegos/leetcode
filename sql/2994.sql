-- https://leetcode.com/problems/friday-purchases-ii/description/

with recursive novs as (
    select 1 as week_of_month, date('2023-11-03') as purchase_date
    
    union
    
    select week_of_month + 1, date(purchase_date + interval '7 day')
    from novs
    where week_of_month < 4
)

select
    a.week_of_month,
    a.purchase_date,
    coalesce(sum(b.amount_spend), 0) as total_amount
from novs a
    left join purchases b on a.purchase_date = b.purchase_date
group by 1, 2
order by 1;