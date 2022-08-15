-- https://leetcode.com/problems/customers-who-bought-all-products/

-- bad
select customer_id
from (
    select distinct customer_id, product_key
    from Customer
    ) a cross join Product b
group by customer_id
having sum(a.product_key=b.product_key) = (select count(1) from Product)


-- obviously this
select customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(1) from Product)