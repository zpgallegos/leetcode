-- https://leetcode.com/problems/number-of-accounts-that-did-not-stream/
SELECT
    COUNT(DISTINCT A.account_id) AS accounts_count
FROM
    (
        SELECT
            account_id
        FROM
            Subscriptions
        WHERE
            (
                YEAR(start_date) = 2021
                OR YEAR(end_date) = 2021
            )
            OR (
                YEAR(start_date) < 2021
                AND YEAR(end_date) > 2021
            )
    ) A
    LEFT JOIN (
        SELECT
            account_id
        FROM
            streams
        WHERE
            YEAR(stream_date) = 2021
    ) b ON A.account_id = b.account_id
WHERE
    b.account_id IS NULL;