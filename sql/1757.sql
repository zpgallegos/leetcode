-- https://leetcode.com/problems/recyclable-and-low-fat-products/description/

select product_id
from products
where
    1=1
    and low_fats = 'Y'
    and recyclable = 'Y';