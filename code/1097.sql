-- https://leetcode.com/problems/game-play-analysis-v/
WITH cte AS (
    SELECT
        player_id,
        event_date,
        row_number() over win AS rw,
        lead(event_date, 1) over win AS lead_date
    FROM
        (
            SELECT
                DISTINCT player_id,
                event_date
            FROM
                activity
        ) s window win AS (
            PARTITION by player_id
            ORDER BY
                event_date
        )
)
SELECT
    event_date AS install_dt,
    count(1) AS installs,
    round(sum(retained) / count(1), 2) AS Day1_retention
FROM
    (
        SELECT
            *,
            coalesce(
                date_add(event_date, INTERVAL 1 DAY) = lead_date,
                0
            ) AS retained
        FROM
            cte
        WHERE
            rw = 1
    ) s
GROUP BY
    event_date;