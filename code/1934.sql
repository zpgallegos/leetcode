-- https://leetcode.com/problems/confirmation-rate/
WITH rates AS (
    SELECT
        user_id,
        round(sum(ACTION = 'confirmed') / count(1), 2) AS confirmation_rate
    FROM
        confirmations
    GROUP BY
        user_id
)
SELECT
    *
FROM
    rates
UNION
SELECT
    user_id,
    0 AS confirmation_rate
FROM
    Signups
WHERE
    user_id NOT IN(
        SELECT
            user_id
        FROM
            rates
    );