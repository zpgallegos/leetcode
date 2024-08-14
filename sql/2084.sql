-- https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/description/

select *
from orders a
where not (
    a.customer_id in(select distinct customer_id from orders where order_type = 0) and
    a.order_type = 1
);
