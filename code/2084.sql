-- https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/
WITH zero AS (
    SELECT
        *
    FROM
        orders
    WHERE
        order_type = 0
)
SELECT
    *
FROM
    zero
UNION
SELECT
    *
FROM
    orders
WHERE
    customer_id NOT IN(
        SELECT
            customer_id
        FROM
            zero
    );