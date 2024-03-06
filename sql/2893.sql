-- https://leetcode.com/problems/calculate-orders-within-each-interval/

with cte as (
    select ceiling(minute / 6) as interval_no, order_count
    from orders
)

select * from (
    select interval_no, sum(order_count) as total_orders
    from cte
    group by interval_no
) sub order by interval_no;