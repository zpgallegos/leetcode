-- https://leetcode.com/problems/leetcodify-friends-recommendations/
WITH overlap AS (
    SELECT
        a.user_id AS user1,
        b.user_id AS user2,
        b.day
    FROM
        listens a
        INNER JOIN listens b ON a.song_id = b.song_id
        AND a.day = b.day
    WHERE
        a.user_id < b.user_id
    GROUP BY
        a.user_id,
        b.user_id,
        b.day
    HAVING
        count(DISTINCT b.song_id) >= 3
),
recs AS (
    SELECT
        DISTINCT user1 AS user_id,
        user2 AS recommended_id
    FROM
        overlap
    WHERE
        (user1, user2) NOT IN (
            SELECT
                *
            FROM
                friendship
        )
)
SELECT
    *
FROM
    recs
UNION
SELECT
    recommended_id AS user_id,
    user_id AS recommended_id
FROM
    recs