-- https://leetcode.com/problems/fix-product-name-format/description/

-- mysql, no postgres for this question
select
    trim(lower(product_name)) as product_name,
    date_format(sale_date, '%Y-%m') as sale_date,
    count(1) as total
from sales
group by 1, 2
order by 1, 2;