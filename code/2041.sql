-- https://leetcode.com/problems/accepted-candidates-from-the-interviews/
SELECT
    candidate_id
FROM
    Candidates a
    INNER JOIN (
        SELECT
            interview_id,
            sum(score) AS points
        FROM
            Rounds
        GROUP BY
            interview_id
    ) s ON a.interview_id = s.interview_id
WHERE
    a.years_of_exp >= 2
    AND s.points > 15;