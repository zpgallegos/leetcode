-- https://leetcode.com/problems/find-category-recommendation-pairs/

with cats as (
    select distinct
        a.user_id,
        b.category
    from productpurchases a
    inner join productinfo b on a.product_id = b.product_id
)

select
    a.category as category1,
    b.category as category2,
    count(a.user_id) as customer_count
from cats a
inner join cats b on a.user_id = b.user_id and a.category < b.category
group by 1, 2
having count(a.user_id) >= 3
order by 3 desc, 1, 2;