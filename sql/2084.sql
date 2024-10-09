-- https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/description/

with zero as (
    select distinct customer_id
    from orders
    where order_type = 0
)

select *
from orders
where not(
    1=1
    and customer_id in(select * from zero)
    and order_type = 1
)
