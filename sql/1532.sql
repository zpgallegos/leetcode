-- https://leetcode.com/problems/the-most-recent-three-orders/


select
    customer_name,
    customer_id,
    order_id,
    order_date
from (
    select
        b.name as customer_name,
        a.customer_id,
        a.order_id,
        a.order_date,
        rank() over(partition by a.customer_id order by a.order_date desc) as rnk
    from Orders a inner join Customers b on a.customer_id = b.customer_id
) s
where rnk <= 3
order by customer_name, customer_id, order_date desc;
