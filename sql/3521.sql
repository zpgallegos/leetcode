-- https://leetcode.com/problems/find-product-recommendation-pairs/

with

cte as (
    select
        a.*,
        b.category
    from productpurchases a
    inner join productinfo b on a.product_id = b.product_id
)

select
    a.product_id as product1_id,
    b.product_id as product2_id,
    a.category as product1_category,
    b.category as product2_category,
    count(1) as customer_count
from cte a
inner join cte b on a.user_id = b.user_id and a.product_id < b.product_id
group by 1, 2, 3, 4
having count(1) >= 3
order by 5 desc, 1, 2;