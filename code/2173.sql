-- https://leetcode.com/problems/longest-winning-streak/
WITH cte AS (
    SELECT
        *,
        sum(chg) over(
            PARTITION by player_id
            ORDER BY
                match_day
        ) AS grp
    FROM
        (
            SELECT
                *,
                IF(
                    coalesce(result != lag(result, 1) over win, 1),
                    1,
                    0
                ) AS chg
            FROM
                matches window win AS (
                    PARTITION by player_id
                    ORDER BY
                        match_day
                )
        ) q
),
wins AS (
    SELECT
        player_id,
        grp,
        count(1) AS wins
    FROM
        cte
    WHERE
        result = 'Win'
    GROUP BY
        player_id,
        grp
),
longest AS (
    SELECT
        player_id,
        max(wins) AS longest_streak
    FROM
        wins
    GROUP BY
        player_id
)
SELECT
    *
FROM
    longest
UNION
SELECT
    DISTINCT player_id,
    0 AS longest
FROM
    matches
WHERE
    player_id NOT IN(
        SELECT
            player_id
        FROM
            longest
    )