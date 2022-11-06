-- https://leetcode.com/problems/market-analysis-i/

with cte as (
    select
        buyer_id,
        count(1) as orders_in_2019
    from orders
    where year(order_date) = 2019
    group by buyer_id
)

select
    a.user_id as buyer_id,
    a.join_date,
    coalesce(b.orders_in_2019, 0) as orders_in_2019

from users a
    left join cte b on a.user_id = b.buyer_id;
