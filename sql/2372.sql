-- https://leetcode.com/problems/calculate-the-influence-of-each-salesperson/
WITH cte AS (
    SELECT
        b.salesperson_id,
        c.name,
        sum(a.price) AS total
    FROM
        sales a
        INNER JOIN customer b ON a.customer_id = b.customer_id
        INNER JOIN salesperson c ON b.salesperson_id = c.salesperson_id
    GROUP BY
        b.salesperson_id,
        c.name
)
SELECT
    *
FROM
    cte
UNION
SELECT
    *,
    0 AS total
FROM
    salesperson
WHERE
    salesperson_id NOT IN(
        SELECT
            salesperson_id
        FROM
            cte
    );