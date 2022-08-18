-- https://leetcode.com/problems/market-analysis-ii/
WITH ranked AS (
    SELECT
        orders.seller_id,
        rank() over(
            PARTITION by orders.seller_id
            ORDER BY
                orders.order_date
        ) AS order_no,
        items.item_brand = users.favorite_brand AS is_favorite
    FROM
        orders
        INNER JOIN users ON orders.seller_id = users.user_id
        INNER JOIN items ON orders.item_id = items.item_id
),
cte AS (
    SELECT
        seller_id,
        is_favorite
    FROM
        ranked
    WHERE
        order_no = 2
)
SELECT
    seller_id,
    IF(is_favorite, 'yes', 'no') AS 2nd_item_fav_brand
FROM
    (
        SELECT
            *
        FROM
            cte
        UNION
        (
            SELECT
                user_id AS seller_id,
                0 AS is_favorite
            FROM
                users
            WHERE
                user_id NOT IN (
                    SELECT
                        seller_id
                    FROM
                        cte
                )
        )
    ) q