-- https://leetcode.com/problems/customers-with-strictly-increasing-purchases/

with tbl as (
    select
        a.customer_id,
        date_part('year', a.order_date) as yr,
        sum(a.price) as total
    from orders a
    group by 1, 2
),
cte as (
    select
        a.*,
        a.yr - lag(a.yr, 1) over win as year_diff,
        a.total - lag(a.total, 1) over win as total_diff
    from tbl a
    window win as (partition by a.customer_id order by a.yr)
)

select distinct customer_id from cte except
select distinct customer_id from cte where year_diff > 1 or total_diff <= 0;
