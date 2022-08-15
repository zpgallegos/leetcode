-- https://leetcode.com/problems/bank-account-summary/
WITH trans AS (
    SELECT
        paid_by AS user_id,
        amount * -1 AS amount
    FROM
        Transactions
    UNION
    ALL
    SELECT
        paid_to AS user_id,
        amount
    FROM
        Transactions
)
SELECT
    a.user_id,
    a.user_name,
    a.credit + coalesce(s.net, 0) AS credit,
    IF(a.credit + coalesce(s.net, 0) < 0, 'Yes', 'No') AS credit_limit_breached
FROM
    Users a
    LEFT JOIN (
        SELECT
            user_id,
            sum(amount) AS net
        FROM
            trans
        GROUP BY
            user_id
    ) s ON a.user_id = s.user_id