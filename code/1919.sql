-- https://leetcode.com/problems/leetcodify-similar-friends/
WITH similar AS (
    SELECT
        DISTINCT user1,
        user2
    FROM
        (
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
        ) q
)
SELECT
    user1 as user1_id,
    user2 as user2_id
FROM
    similar
WHERE
    (user1, user2) IN (
        SELECT
            *
        FROM
            friendship
    )