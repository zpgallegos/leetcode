-- https://leetcode.com/problems/total-sales-amount-by-year/description/

with recursive cte as (
    select 
        a.product_id, 
        a.period_start as dt,
        a.average_daily_sales
    from sales a
    
    union all

    select 
        a.product_id, 
        date_add(a.dt, interval 1 day) as dt,
        b.average_daily_sales
    from cte a
        inner join sales b on a.product_id = b.product_id
    where a.dt < b.period_end
)

select
    sub.product_id,
    b.product_name,
    cast(sub.report_year as char(4)) as report_year,
    sub.total_amount
from (
    select 
        a.product_id,
        year(a.dt) as report_year,
        sum(a.average_daily_sales) as total_amount
    from cte a
    group by 1, 2
) sub
    inner join product b on sub.product_id = b.product_id
order by 1, 3;