-- https://leetcode.com/problems/the-most-recent-three-orders/

with cte as (
    select
        a.*,
        row_number() over(partition by a.customer_id order by a.order_date desc) as rn
    from orders a
),
res as (
    select * from cte where rn <= 3
)

select
    b.name as customer_name,
    a.customer_id,
    a.order_id,
    a.order_date
from res a
    inner join customers b on a.customer_id = b.customer_id
order by 1, 2, 4 desc;