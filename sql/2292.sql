-- https://leetcode.com/problems/products-with-three-or-more-orders-in-two-consecutive-years/description/

with cte as (
    select
        a.product_id,
        extract(year from a.purchase_date) as yr
    from orders a
    group by 1, 2
    having count(1) >= 3
)

select distinct a.product_id
from cte a
    inner join cte b on a.product_id = b.product_id and a.yr = b.yr + 1;