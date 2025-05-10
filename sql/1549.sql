-- https://leetcode.com/problems/the-most-recent-orders-for-each-product/description/

with

cte as (
    select
        *,
        rank() over(partition by product_id order by order_date desc) as rn
    from orders
)

select
    b.product_name,
    b.product_id,
    a.order_id,
    a.order_date
from cte a
inner join products b on a.product_id = b.product_id
where a.rn = 1
order by 1, 2, 3;