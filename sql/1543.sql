-- https://leetcode.com/problems/fix-product-name-format/description/

with cte as (
    select trim(lower(product_name)) as product_name, format(sale_date, 'yyyy-MM') as sale_date
    from sales
)

select product_name, sale_date, count(1) as total
from cte
group by product_name, sale_date
order by product_name, sale_date;