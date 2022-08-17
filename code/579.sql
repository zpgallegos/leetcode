-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/
WITH cte AS (
    SELECT
        a.id,
        a.month,
        lag(a.month, 1) over win AS month_1,
        lag(a.month, 2) over win AS month_2,
        a.salary,
        lag(a.salary, 1) over win AS salary_1,
        lag(a.salary, 2) over win AS salary_2
    FROM
        Employee a
        INNER JOIN (
            SELECT
                id,
                max(MONTH) AS max_month
            FROM
                Employee
            GROUP BY
                id
        ) b
    WHERE
        a.id = b.id
        AND a.month < b.max_month window win AS (
            PARTITION by id
            ORDER BY
                MONTH
        )
)
SELECT
    id,
    MONTH,
    salary + IF(MONTH - 1 = month_1, salary_1, 0) + IF(MONTH - 2 = month_2, salary_2, 0) AS Salary
FROM
    cte
ORDER BY
    id,
    MONTH DESC