-- https://leetcode.com/problems/orders-with-maximum-quantity-above-average/


with stats as (
    select
        order_id,
        max(quantity) as max_quantity,
        avg(quantity) as avg_quantity
    from OrdersDetails
    group by order_id
)

select order_id
from stats
where max_quantity > (select max(avg_quantity) from stats);