-- https://leetcode.com/problems/count-the-number-of-experiments/
WITH p AS (
    SELECT
        'Android' AS platform
    UNION
    SELECT
        'IOS' AS platform
    UNION
    SELECT
        'Web' AS platform
),
e AS (
    SELECT
        'Reading' AS experiment_name
    UNION
    SELECT
        'Sports' AS experiment_name
    UNION
    SELECT
        'Programming' AS experiment_name
),
TYPES AS (
    SELECT
        *
    FROM
        p
        CROSS JOIN e
),
cnts AS (
    SELECT
        platform,
        experiment_name,
        count(1) AS num_experiments
    FROM
        Experiments
    GROUP BY
        1,
        2
)
SELECT
    *
FROM
    cnts
UNION
SELECT
    *,
    0 AS num_experiments
FROM
    TYPES
WHERE
    (platform, experiment_name) NOT IN (
        SELECT
            platform,
            experiment_name
        FROM
            cnts
    );