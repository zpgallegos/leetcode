-- https://leetcode.com/problems/account-balance/
WITH cte AS (
    SELECT
        *,
        IF(TYPE = 'Withdraw', -1 * amount, amount) AS amt
    FROM
        Transactions
)
SELECT
    *
FROM
    (
        SELECT
            account_id,
            DAY,
            sum(amt) over(
                PARTITION by account_id
                ORDER BY
                    DAY ROWS BETWEEN unbounded preceding
                    AND current ROW
            ) AS balance
        FROM
            cte
    ) q
ORDER BY
    q.account_id,
    q.day