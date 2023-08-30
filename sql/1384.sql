-- https://leetcode.com/problems/total-sales-amount-by-year/

with recursive cte as (
    select
        year(period_start) as report_year,
        product_id,
        period_start,
        case
        when year(period_start) = year(period_end) then period_end
        else cast(concat(year(period_start), '-12-31') as date)
        end as period_end,
        average_daily_sales
    from Sales

    union

    select
        b.report_year + 1 as report_year,
        b.product_id,
        cast(concat(b.report_year + 1, '-01-01') as date) as period_start,
        case
        when b.report_year + 1 = year(a.period_end) then a.period_end
        else cast(concat(b.report_year + 1, '-12-31') as date)
        end as period_end,
        a.average_daily_sales

    from Sales a inner join cte b on a.product_id = b.product_id
    where b.report_year + 1 between year(a.period_start) + 1 and year(a.period_end) 
)

select
    a.product_id,
    b.product_name,
    cast(a.report_year as nchar(4)) as report_year,
    (datediff(a.period_end, a.period_start) + 1) * a.average_daily_sales as total_amount

from cte a inner join Product b on a.product_id = b.product_id

order by a.product_id, a.report_year;