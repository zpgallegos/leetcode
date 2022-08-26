-- https://leetcode.com/problems/change-null-values-in-a-table-to-the-previous-value/
WITH cte AS (
    SELECT
        *,
        SUM(IF(drink IS NOT NULL, 1, 0)) over win AS grp
    FROM
        CoffeeShop 
    WINDOW win AS (
        ROWS BETWEEN UNBOUNDED preceding
        AND CURRENT ROW
        )
)

SELECT
    id,
    first_value(drink) over(PARTITION by grp) AS drink
FROM
    cte;