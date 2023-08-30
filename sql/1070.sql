-- https://leetcode.com/problems/product-sales-analysis-iii/
SELECT
    a.product_id,
    s.first_year,
    a.quantity,
    a.price
FROM
    sales a
    INNER JOIN (
        SELECT
            product_id,
            min(year) AS first_year
        FROM
            sales
        GROUP BY
            product_id
    ) s ON a.product_id = s.product_id
    AND a.year = s.first_year;

SELECT
    product_id,
    a.year AS first_year,
    quantity,
    price
FROM
    (
        SELECT
            *,
            rank() over(
                PARTITION by product_id
                ORDER BY
                    year
            ) AS rnk
        FROM
            sales
    ) a
WHERE
    rnk = 1