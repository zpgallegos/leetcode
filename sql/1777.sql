-- https://leetcode.com/problems/products-price-for-each-store/


select
    product_id,
    max(case when store = 'store1' then price end) as store1,
    max(case when store = 'store2' then price end) as store2,
    max(case when store = 'store3' then price end) as store3
from products
group by 1