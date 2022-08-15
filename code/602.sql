-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
WITH friends AS (
    SELECT
        requester_id AS id,
        accepter_id friend
    FROM
        requestaccepted
    UNION
    SELECT
        accepter_id AS id,
        requester_id friend
    FROM
        requestaccepted
),
friend_count AS (
    SELECT
        id,
        count(1) AS num
    FROM
        friends
    GROUP BY
        id
)
SELECT
    *
FROM
    friend_count
WHERE
    num = (
        SELECT
            max(num)
        FROM
            friend_count
    )