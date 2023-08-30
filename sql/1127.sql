-- https://leetcode.com/problems/user-purchase-platform/
WITH user_class AS (
    SELECT
        s.user_id,
        s.spend_date,
        CASE
            WHEN mobile_cnt > 0
            AND desktop_cnt = 0 THEN 'mobile'
            WHEN mobile_cnt = 0
            AND desktop_cnt > 0 THEN 'desktop'
            ELSE 'both'
        END AS class
    FROM
        (
            SELECT
                user_id,
                spend_date,
                sum(platform = 'mobile') AS mobile_cnt,
                sum(platform = 'desktop') AS desktop_cnt
            FROM
                Spending
            GROUP BY
                user_id,
                spend_date
        ) s
),
cte AS (
    SELECT
        s.spend_date,
        cls.class AS platform,
        sum(s.amount) AS total_amount,
        count(DISTINCT s.user_id) AS total_users
    FROM
        spending s
        INNER JOIN user_class cls ON s.user_id = cls.user_id
        AND s.spend_date = cls.spend_date
    GROUP BY
        s.spend_date,
        cls.class
),
missing AS (
    SELECT
        dates.spend_date,
        platforms.platform
    FROM
        (
            SELECT
                DISTINCT spend_date
            FROM
                cte
        ) dates
        CROSS JOIN (
            SELECT
                'desktop' AS platform
            UNION
            SELECT
                'mobile' AS platform
            UNION
            SELECT
                'both' AS platform
        ) platforms
    WHERE
        (
            dates.spend_date,
            platforms.platform
        ) NOT IN (
            SELECT
                spend_date,
                platform
            FROM
                cte
        )
)
SELECT
    *
FROM
    cte
UNION
SELECT
    *,
    0 AS total_amount,
    0 AS total_users
FROM
    missing