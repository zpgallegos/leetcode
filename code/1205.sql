-- https://leetcode.com/problems/monthly-transactions-ii/
WITH t AS (
    SELECT
        *,
        date_format(trans_date, '%Y-%m') AS "month"
    FROM
        Transactions
),
c AS (
    SELECT
        *,
        date_format(trans_date, '%Y-%m') AS "month"
    FROM
        Chargebacks
),
approved AS (
    SELECT
        t.month,
        t.country,
        sum(t.state = 'approved') AS approved_count,
        sum(IF(t.state = 'approved', amount, 0)) AS approved_amount
    FROM
        t
    GROUP BY
        t.month,
        t.country
),
chargebacks AS (
    SELECT
        c.month,
        t.country,
        count(1) AS chargeback_count,
        sum(t.amount) AS chargeback_amount
    FROM
        c
        INNER JOIN t ON c.trans_id = t.id
    GROUP BY
        c.month,
        t.country
)
SELECT
    *
FROM
    (
        SELECT
            a.*,
            coalesce(b.chargeback_count, 0) AS chargeback_count,
            coalesce(b.chargeback_amount, 0) AS chargeback_amount
        FROM
            approved a
            LEFT JOIN chargebacks b ON a.month = b.month
            AND a.country = b.country
        UNION
        SELECT
            a.month,
            a.country,
            coalesce(b.approved_count, 0) AS approved_count,
            coalesce(b.approved_amount, 0) AS approved_amount,
            a.chargeback_count,
            a.chargeback_amount
        FROM
            chargebacks a
            LEFT JOIN approved b ON a.month = b.month
            AND a.country
            AND b.country
        WHERE
            (a.month, a.country) NOT IN (
                SELECT
                    MONTH,
                    country
                FROM
                    approved
            )
    ) q
WHERE
    approved_count > 0
    OR chargeback_count > 0