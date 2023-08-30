-- https://leetcode.com/problems/get-highest-answer-rate-question/
WITH rates AS (
    SELECT
        question_id,
        sum(answer_id IS NOT NULL) / sum(ACTION = 'show') AS ans_rate
    FROM
        surveylog
    GROUP BY
        question_id
)
SELECT
    *
FROM
    (
        SELECT
            question_id AS survey_log
        FROM
            rates
        WHERE
            ans_rate = (
                SELECT
                    max(ans_rate)
                FROM
                    rates
            )
        ORDER BY
            question_id
    ) s
LIMIT
    1;