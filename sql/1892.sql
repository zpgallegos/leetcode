-- https://leetcode.com/problems/page-recommendations-ii/
WITH friends AS (
    SELECT
        user1_id AS user_id,
        user2_id AS friend_id
    FROM
        friendship
    UNION
    SELECT
        user2_id AS user_id,
        user1_id AS friend_id
    FROM
        friendship
)
SELECT
    a.user_id,
    b.page_id,
    count(1) AS friends_likes
FROM
    friends a
    INNER JOIN likes b ON a.friend_id = b.user_id
    LEFT JOIN likes c ON a.user_id = c.user_id
    AND b.page_id = c.page_id
WHERE
    c.page_id IS NULL
GROUP BY
    a.user_id,
    b.page_id