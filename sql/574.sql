-- https://leetcode.com/problems/winning-candidate/
WITH cte AS (
    SELECT
        candidateId,
        count(1) AS votes
    FROM
        Vote
    GROUP BY
        candidateId
)
SELECT
    name
FROM
    Candidate
WHERE
    id = (
        SELECT
            candidateId
        FROM
            cte
        WHERE
            votes = (
                SELECT
                    max(votes)
                FROM
                    cte
            )
    )