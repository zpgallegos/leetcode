-- https://leetcode.com/problems/tournament-winners/
WITH cte AS (
    SELECT
        players.group_id,
        scores.player_id,
        sum(scores.score) AS total
    FROM
        (
            SELECT
                match_id,
                first_player AS player_id,
                first_score AS score
            FROM
                matches
            UNION
            SELECT
                match_id,
                second_player AS player_id,
                second_score AS second_score
            FROM
                matches
        ) scores
        INNER JOIN players ON scores.player_id = players.player_id
    GROUP BY
        players.group_id,
        scores.player_id
),
ranked AS (
    SELECT
        *,
        row_number() over(
            PARTITION by group_id
            ORDER BY
                total DESC,
                player_id
        ) AS rw
    FROM
        cte
)
SELECT
    group_id,
    player_id
FROM
    ranked
WHERE
    rw = 1