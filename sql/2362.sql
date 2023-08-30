-- https://leetcode.com/problems/generate-the-invoice/
WITH totals AS (
    SELECT
        purchases.invoice_id,
        sum(purchases.quantity * products.price) AS ttl
    FROM
        purchases
        INNER JOIN products ON purchases.product_id = products.product_id
    GROUP BY
        purchases.invoice_id
),
ranked AS (
    SELECT
        *,
        rank() over(
            ORDER BY
                ttl DESC,
                invoice_id
        ) AS rnk
    FROM
        totals
)
SELECT
    purchases.product_id,
    purchases.quantity,
    purchases.quantity * products.price as price
FROM
    purchases
    INNER JOIN products ON purchases.product_id = products.product_id
    INNER JOIN (
        SELECT
            invoice_id
        FROM
            ranked
        WHERE
            rnk = 1
    ) q ON purchases.invoice_id = q.invoice_id