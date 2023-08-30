-- https://leetcode.com/problems/the-change-in-global-rankings/
SELECT
    team_id,
    name,
    -- have to do this because rank() produces an unsigned integer by default
    cast(init_rank AS signed) - cast(next_rank AS signed) AS rank_diff
FROM
    (
        SELECT
            a.team_id,
            a.name,
            rank() over(
                ORDER BY
                    a.points DESC,
                    a.name
            ) AS init_rank,
            rank() over(
                ORDER BY
                    a.points + b.points_change DESC,
                    a.name
            ) AS next_rank
        FROM
            TeamPoints a
            INNER JOIN PointsChange b ON a.team_id = b.team_id
    ) q