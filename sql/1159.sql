-- https://leetcode.com/problems/market-analysis-ii/

with seconds as (
    select *
    from (
        select
            *,
            rank() over(partition by seller_id order by order_date) as rnk
        from orders
    ) q
    where rnk = 2
)

select
    seconds.seller_id,
    if(users.favorite_brand = items.item_brand, 'yes', 'no') as 2nd_item_fav_brand

from seconds
    inner join users on seconds.seller_id = users.user_id
    inner join items on seconds.item_id = items.item_id

union

select user_id as seller_id, 'no' as 2nd_item_fav_brand
from users
where user_id not in(select seller_id from seconds)