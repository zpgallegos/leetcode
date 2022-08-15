-- https://leetcode.com/problems/product-sales-analysis-iv/
WITH s AS (
    SELECT
        a.user_id,
        a.product_id,
        sum(a.quantity * b.price) AS spent
    FROM
        sales a
        INNER JOIN product b ON a.product_id = b.product_id
    GROUP BY
        a.user_id,
        a.product_id
)
SELECT
    s.user_id,
    s.product_id
FROM
    s
    INNER JOIN (
        SELECT
            user_id,
            max(spent) AS mx
        FROM
            s
        GROUP BY
            user_id
    ) q ON s.user_id = q.user_id
    AND s.spent = q.mx;

-- using rank
WITH s AS (
    SELECT
        a.user_id,
        a.product_id,
        sum(a.quantity * b.price) AS spent,
        rank() over(
            PARTITION by user_id
            ORDER BY
                sum(a.quantity * b.price) DESC
        ) AS rnk
    FROM
        sales a
        INNER JOIN product b ON a.product_id = b.product_id
    GROUP BY
        a.user_id,
        a.product_id
)
SELECT
    s.user_id,
    s.product_id
FROM
    s
WHERE
    rnk = 1;