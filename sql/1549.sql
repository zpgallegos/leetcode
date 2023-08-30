-- https://leetcode.com/problems/the-most-recent-orders-for-each-product/


with lst as (
    select
        a.product_id,
        a.product_name,
        max(order_date) as last_order_date

    from Products a
        inner join Orders b on a.product_id = b.product_id
    
    group by 1, 2
)

select a.product_name, a.product_id, b.order_id, b.order_date
from lst a 
    inner join Orders b on a.product_id = b.product_id and a.last_order_date = b.order_date
order by a.product_name, a.product_id, b.order_id;



select
    product_name,
    product_id,
    order_id,
    order_date
from (
    select
        a.product_name,
        a.product_id,
        b.order_id,
        b.order_date,
        rank() over(partition by a.product_id order by b.order_date desc) as rnk

    from Products a
        inner join Orders b on a.product_id = b.product_id
) s
where rnk = 1
order by product_name, product_id, order_id;