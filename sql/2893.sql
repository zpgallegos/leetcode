-- https://leetcode.com/problems/calculate-orders-within-each-interval/description/

select
    ceiling(a.minute / 6) as interval_no,
    sum(a.order_count) as total_orders
from orders a
group by 1
order by 1;