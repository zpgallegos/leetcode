-- https://leetcode.com/problems/count-salary-categories/
WITH cnts AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 0
            WHEN income <= 50000 THEN 1
            ELSE 2
        END AS ord,
        count(1) AS accounts_count
    FROM
        accounts
    GROUP BY
        CASE
            WHEN income < 20000 THEN 0
            WHEN income <= 50000 THEN 1
            ELSE 2
        END
)
SELECT
    CASE
        ord
        WHEN 0 THEN 'Low Salary'
        WHEN 1 THEN 'Average Salary'
        ELSE 'High Salary'
    END AS category,
    accounts_count
FROM
    (
        SELECT
            *
        FROM
            cnts
        UNION
        SELECT
            *
        FROM
            (
                SELECT
                    0 AS ord,
                    0 AS accounts_count
                UNION
                SELECT
                    1 AS ord,
                    0 AS accounts_count
                UNION
                SELECT
                    2 AS ord,
                    0 AS accounts_count
            ) s
        WHERE
            s.ord NOT IN(
                SELECT
                    ord
                FROM
                    cnts
            )
    ) q
ORDER BY
    q.ord