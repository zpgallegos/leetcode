-- https://leetcode.com/problems/market-analysis-iii/description/

with cte as (
    select
        users.seller_id,
        count(distinct orders.item_id) as num_items
    from orders
        inner join users on orders.seller_id = users.seller_id
        inner join items on orders.item_id = items.item_id
    where items.item_brand <> users.favorite_brand
    group by users.seller_id
)

select *
from cte
where num_items = (select max(num_items) from cte)
order by seller_id;