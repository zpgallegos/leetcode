-- https://leetcode.com/problems/market-analysis-i/description/?lang=pythondata

select
    users.user_id as buyer_id,
    users.join_date,
    coalesce(sub.cnt, 0) as orders_in_2019

from users
    left join (
        select buyer_id, count(1) as cnt
        from orders
        where year(order_date) = 2019
        group by buyer_id
    ) sub on users.user_id = sub.buyer_id;