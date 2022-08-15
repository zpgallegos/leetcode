-- https://leetcode.com/problems/team-scores-in-football-tournament/
SELECT
    *
FROM
    (
        SELECT
            b.team_id,
            b.team_name,
            coalesce(sum(s.points), 0) AS num_points
        FROM Teams b left join 
            (
                SELECT
                    match_id,
                    host_team AS team_id,
                    CASE
                        WHEN host_goals > guest_goals THEN 3
                        WHEN host_goals = guest_goals THEN 1
                        ELSE 0
                    END AS points
                FROM
                    Matches
                UNION
                SELECT
                    match_id,
                    guest_team AS team_id,
                    CASE
                        WHEN guest_goals > host_goals THEN 3
                        WHEN guest_goals = host_goals THEN 1
                        ELSE 0
                    END AS points
                FROM
                    Matches
            ) s ON s.team_id = b.team_id
        GROUP BY
            1,
            2
    ) q
ORDER BY
    num_points DESC,
    team_id;