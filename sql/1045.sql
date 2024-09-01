-- https://leetcode.com/problems/customers-who-bought-all-products/description/

select a.customer_id
from customer a
group by 1
having count(distinct a.product_key) = (select count(1) from product);