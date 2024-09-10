-- https://leetcode.com/problems/market-analysis-iii/description/

with cte as (
    select
        a.seller_id,
        count(distinct a.item_id) as num_items
    from orders a
        inner join items b on a.item_id = b.item_id
        inner join users c on a.seller_id = c.seller_id
    where b.item_brand != c.favorite_brand
    group by 1
)

select *
from cte
where num_items = (select max(num_items) from cte)
order by 1;
