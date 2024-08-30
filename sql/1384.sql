-- https://leetcode.com/problems/total-sales-amount-by-year/description/

with recursive cte as (
    select
        a.product_id,
        a.average_daily_sales,
        a.period_start as dt
    from sales a

    union

    select
        a.product_id,
        a.average_daily_sales,
        date_add(a.dt, interval 1 day) as dt
    from cte a
        inner join sales b on a.product_id = b.product_id
    where a.dt < b.period_end
)

select
    a.product_id,
    b.product_name,
    cast(year(a.dt) as char(4)) as report_year,
    sum(a.average_daily_sales) as total_amount
from cte a
    inner join product b on a.product_id = b.product_id
group by 1, 2, 3
order by 1, 3;