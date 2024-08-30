-- https://leetcode.com/problems/market-analysis-ii/description/


with ranked as (
    select
        a.seller_id,
        b.item_brand,
        row_number() over win as rn
    from orders a
        inner join items b on a.item_id = b.item_id
    window win as (partition by a.seller_id order by a.order_date)
),
secnd as (
    select * from ranked where rn = 2
)

select
    a.user_id as seller_id,
    if(b.seller_id is null or a.favorite_brand != b.item_brand, 'no', 'yes') as 2nd_item_fav_brand
from users a
    left join secnd b on a.user_id = b.seller_id;