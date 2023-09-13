-- https://leetcode.com/problems/sales-analysis-ii/

with cte as (
    select buyer_id, product.product_name
    from sales
        inner join product on sales.product_id = product.product_id
)

select distinct buyer_id
from cte 
where
    product_name = "S8" and
    buyer_id not in(select buyer_id from cte where product_name = "iPhone");