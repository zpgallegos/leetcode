-- https://leetcode.com/problems/customer-order-frequency/description/


with sub as (
    select *, month(order_date) as mnth
    from orders 
    where order_date between '2020-06-01' and '2020-07-31'
), grpd as (
    select customer_id, mnth
    from sub a inner join product b on a.product_id = b.product_id
    group by customer_id, mnth
    having sum(a.quantity * b.price) >= 100
), incl as (
    select customer_id
    from grpd
    group by customer_id
    having count(1) = 2
)

select a.customer_id, b.name
from incl a inner join customers b on a.customer_id = b.customer_id;