-- https://leetcode.com/problems/sales-analysis-i/

with cte as (
    select seller_id, sum(price) as total
    from sales
    group by seller_id
)

select seller_id
from cte
where total = (select max(total) from cte);

