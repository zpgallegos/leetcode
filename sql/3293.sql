-- https://leetcode.com/problems/calculate-product-final-price/


select
    a.product_id,
    a.price * (1 - coalesce(b.discount, 0) / 100) as final_price,
    a.category
from products a
    left join discounts b on a.category = b.category
order by 1;
