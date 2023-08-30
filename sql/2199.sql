-- https://leetcode.com/problems/finding-the-topic-of-each-post/
WITH cte AS (
    SELECT
        DISTINCT posts.post_id,
        keywords.topic_id AS matching_topic
    FROM
        keywords
        INNER JOIN posts ON posts.content RLIKE concat('\\b', keywords.word, '\\b')
),
matches AS (
    SELECT
        post_id,
        GROUP_CONCAT(
            matching_topic
            ORDER BY
                matching_topic SEPARATOR ','
        ) AS topic
    FROM
        cte
    GROUP BY
        post_id
)
SELECT
    *
FROM
    matches
UNION
SELECT
    post_id,
    'Ambiguous!' AS topic
FROM
    posts
WHERE
    post_id NOT IN(
        SELECT
            post_id
        FROM
            matches
    )