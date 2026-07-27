-- https://leetcode.com/problems/seasonal-sales-analysis/

with trans as (
    select
        b.category,
        extract(month from a.sale_date) as sale_month,
        a.quantity,
        a.quantity * a.price as revenue
    from sales a
    inner join products b on a.product_id = b.product_id
),

agg as (
    select
        case
            when sale_month in(1, 2, 12) then 'Winter'
            when sale_month between 3 and 5 then 'Spring'
            when sale_month between 6 and 8 then 'Summer'
            else 'Fall'
        end as season,
        category,
        sum(quantity) as total_quantity,
        sum(revenue) as total_revenue
    from trans
    group by 1, 2
),

ordered as (
    select
        *,
        row_number() over(
            partition by season
            order by total_quantity desc, total_revenue desc, category
        ) as rn
    from agg
)

select season, category, total_quantity, total_revenue
from ordered
where rn = 1
order by season;
