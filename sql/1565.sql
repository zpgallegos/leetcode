-- https://leetcode.com/problems/unique-orders-and-customers-per-month/description/

with cte as (
    select *, format(order_date, 'yyyy-MM') as month
    from orders
    where invoice > 20
)

select month, count(distinct order_id) as order_count, count(distinct customer_id) as customer_count
from cte
group by month;