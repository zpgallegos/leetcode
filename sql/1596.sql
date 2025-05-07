-- https://leetcode.com/problems/the-most-frequently-ordered-products-for-each-customer/description/

with

aggd as (
    select customer_id, product_id, count(1) as cnt
    from orders
    group by 1, 2
),

rnkd as (
    select *, rank() over(partition by customer_id order by cnt desc) as rnk
    from aggd
)

select a.customer_id, a.product_id, b.product_name
from rnkd a
inner join products b on a.product_id = b.product_id
where rnk = 1;