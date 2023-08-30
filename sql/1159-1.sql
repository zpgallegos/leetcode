-- https://leetcode.com/problems/market-analysis-ii/submissions/?lang=pythondata


with cte as (
    select
        orders.seller_id,
        users.favorite_brand,
        items.item_brand,
        row_number() over(partition by orders.seller_id order by orders.order_date) as order_idx

    from orders
        inner join users on orders.seller_id = users.user_id
        inner join items on orders.item_id = items.item_id
),
yes as (
    select seller_id, 'yes' as 2nd_item_fav_brand
    from cte
    where order_idx = 2 and favorite_brand=item_brand
),
nos as (
    select user_id as seller_id, 'no' as 2nd_item_fav_brand
    from users
    where user_id not in(select seller_id from yes)
)

select * from yes
union
select * from nos;

