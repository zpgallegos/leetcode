-- https://leetcode.com/problems/list-the-products-ordered-in-a-period/

select
    a.product_name,
    sum(b.unit) as unit

from products a
    inner join orders b on a.product_id = b.product_id

where b.order_date between '2020-02-01' and '2020-02-29'
group by a.product_name
having sum(b.unit) >= 100;