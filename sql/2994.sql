-- https://leetcode.com/problems/friday-purchases-ii/description/

with weeks as (
    select cast('2023-11-03' as date) as purchase_date, 1 as week_of_month union
    select cast('2023-11-10' as date) as purchase_date, 2 as week_of_month union
    select cast('2023-11-17' as date) as purchase_date, 3 as week_of_month union
    select cast('2023-11-24' as date) as purchase_date, 4 as week_of_month
), cte as (
    select purchase_date, sum(amount_spend) as total_amount
    from purchases
    where datepart(weekday, purchase_date) = 6
    group by purchase_date
)

select
    weeks.week_of_month,
    weeks.purchase_date,
    coalesce(cte.total_amount, 0) as total_amount
from weeks
    left join cte on cte.purchase_date = weeks.purchase_date;
