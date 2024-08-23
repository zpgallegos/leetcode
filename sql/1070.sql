-- https://leetcode.com/problems/product-sales-analysis-iii/


with cte as (
    select
        a.product_id,
        min(a.year) as first_year
    from sales a
    group by 1
)

select
    a.product_id,
    b.first_year,
    a.quantity,
    a.price
from sales a
    inner join cte b on a.product_id = b.product_id and a.year = b.first_year;

-- with window functions...

with cte as (
    select
        a.*,
        rank() over(partition by a.product_id order by a.year) as rn
    from sales a
)

select product_id, year as first_year, quantity, price
from cte
where rn = 1;