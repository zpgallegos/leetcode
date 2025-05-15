-- https://leetcode.com/problems/the-most-recent-three-orders/

with cte as (
    select
        *,
        row_number() over(partition by customer_id order by order_date desc) as rn
    from orders
)

select
    b.name as customer_name,
    a.customer_id,
    a.order_id,
    a.order_date
from cte a
inner join customers b on a.customer_id = b.customer_id
where a.rn <= 3
order by 1, 2, 4 desc;