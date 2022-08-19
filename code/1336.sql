-- https://leetcode.com/problems/number-of-transactions-per-visit/
WITH recursive counts AS (
    SELECT
        transactions_count,
        count(1) AS visits_count
    FROM
        (
            SELECT
                v.user_id,
                v.visit_date,
                count(t.transaction_date) AS transactions_count
            FROM
                visits v
                LEFT JOIN transactions t ON v.user_id = t.user_id
                AND v.visit_date = t.transaction_date
            GROUP BY
                v.user_id,
                v.visit_date
        ) s
    GROUP BY
        transactions_count
),
cte AS (
    SELECT
        *
    FROM
        (
            SELECT
                transactions_count,
                visits_count
            FROM
                counts
            WHERE
                transactions_count = 0
            UNION
            SELECT
                0 AS transactions_count,
                0 AS visits_count
            FROM
                counts
            WHERE
                0 NOT IN(
                    SELECT
                        transactions_count
                    FROM
                        counts
                )
        ) s
    UNION
    SELECT
        cte.transactions_count + 1,
        coalesce(counts.visits_count, 0) AS visits_count
    FROM
        cte
        LEFT JOIN counts ON counts.transactions_count = cte.transactions_count + 1
    WHERE
        cte.transactions_count + 1 <= (
            SELECT
                max(transactions_count)
            FROM
                counts
        )
)
SELECT
    *
FROM
    cte;