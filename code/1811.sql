-- https://leetcode.com/problems/find-interview-candidates/
WITH medals AS (
    SELECT
        contest_id,
        'gold' AS medal,
        gold_medal AS user
    FROM
        contests
    UNION
    SELECT
        contest_id,
        'silver' AS medal,
        silver_medal AS user
    FROM
        contests
    UNION
    SELECT
        contest_id,
        'bronze' AS medal,
        bronze_medal AS user
    FROM
        contests
),
medaled AS (
    SELECT
        user,
        contest_id,
        lag(contest_id, 2) over win AS lag_2
    FROM
        (
            SELECT
                DISTINCT user,
                contest_id
            FROM
                medals
        ) s window win AS (
            PARTITION by user
            ORDER BY
                contest_id
        )
)
SELECT
    b.name, b.mail
FROM
    (
        SELECT
            user
        FROM
            medals
        GROUP BY
            user
        HAVING
            sum(medal = 'gold') >= 3
        UNION
        SELECT
            DISTINCT user
        FROM
            medaled
        WHERE
            contest_id - 2 = lag_2
    ) res inner join Users b on res.user = b.user_id