-- https://leetcode.com/problems/users-with-two-purchases-within-seven-days/
SELECT
    DISTINCT user_id
FROM
    (
        SELECT
            user_id,
            purchase_date,
            lag(purchase_date, 1) over(
                PARTITION by user_id
                ORDER BY
                    purchase_date
            ) AS last_purchase_date
        FROM
            purchases
    ) q
WHERE
    last_purchase_date >= date_sub(purchase_date, INTERVAL 7 DAY);