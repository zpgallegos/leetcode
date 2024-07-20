-- https://leetcode.com/problems/year-on-year-growth-rate/description/

with cte as (
    select
        sub.product_id,
        sub.year,
        sum(sub.spend) as year_spend
    from (
        select 
            a.*, 
            year(a.transaction_date) as year
        from user_transactions a
    ) sub
    group by sub.year, sub.product_id
),
tbl as (
    select
        a.year,
        a.product_id,
        a.year_spend as curr_year_spend,
        lag(a.year_spend, 1) over win as prev_year_spend
    from cte a
    window win as (partition by a.product_id order by a.year)
)

select
    a.year,
    a.product_id,
    a.curr_year_spend,
    a.prev_year_spend,
    round(((a.curr_year_spend - a.prev_year_spend) / a.prev_year_spend) * 100, 2) as yoy_rate
from tbl a
order by a.product_id, a.year;