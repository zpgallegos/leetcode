-- https://leetcode.com/problems/customers-with-strictly-increasing-purchases/

with agg as (
    select
        a.customer_id,
        year(a.order_date) as year,
        sum(price) as total
    from orders a
    group by 1, 2
),
cte as (
    select
        a.customer_id,
        a.year - lag(a.year, 1) over win as year_diff,
        a.total - lag(a.total, 1) over win as total_diff
    from agg a
    window win as (partition by a.customer_id order by a.year)
)

select distinct customer_id
from cte
where customer_id not in(
    select distinct customer_id
    from cte
    where year_diff > 1 or total_diff <= 0
);
