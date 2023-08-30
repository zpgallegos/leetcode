-- https://leetcode.com/problems/products-with-three-or-more-orders-in-two-consecutive-years/
WITH ann AS (
    SELECT
        *,
        IF(qnt >= 3, 1, 0) AS exceeds,
        row_number() over(
            PARTITION by product_id
            ORDER BY
                yr
        ) AS rw
    FROM
        (
            SELECT
                product_id,
                year(purchase_date) AS yr,
                count(1) AS qnt
            FROM
                orders
            GROUP BY
                product_id,
                year(purchase_date)
        ) s
)
SELECT
    DISTINCT product_id
FROM
    (
        SELECT
            *,
            lag(exceeds, 1) over w AS last_exceeds,
            lag(yr, 1) over w AS last_yr
        FROM
            ann window w AS (
                PARTITION by product_id
                ORDER BY
                    yr
            )
    ) q
WHERE
    exceeds
    AND last_exceeds
    AND yr - 1 = last_yr;

-- probably better logic that allows extrapolating to N consecutive years:
-- filter to only years that have the 3 or more orders
-- then group consecutive years and count
WITH cte AS (
    SELECT
        product_id,
        year(purchase_date) AS yr
    FROM
        Orders
    GROUP BY
        product_id,
        year(purchase_date)
    HAVING
        count(1) >= 3
)
SELECT
    DISTINCT product_id
FROM
    (
        SELECT
            product_id,
            yr,
            row_number() over(
                PARTITION by product_id
                ORDER BY
                    yr
            ) AS rw
        FROM
            cte
    ) s
GROUP BY
    product_id,
    yr - rw
HAVING
    count(1) >= 2