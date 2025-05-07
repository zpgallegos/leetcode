-- https://leetcode.com/problems/unique-orders-and-customers-per-month/description/

select
    to_char(order_date, 'yyyy-mm') as month,
    count(1) as order_count
    count(distinct customer_id) as customer_count
from orders
where invoice > 20
group by 1;
