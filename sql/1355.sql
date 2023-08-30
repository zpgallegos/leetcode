-- https://leetcode.com/problems/activity-participants/
WITH cnts AS (
    SELECT
        activity,
        count(1) AS cnt
    FROM
        Friends
    GROUP BY
        activity
)
SELECT
    activity
FROM
    cnts
WHERE
    cnt NOT IN(
        (
            SELECT
                max(cnt)
            FROM
                cnts
        ),
        (
            SELECT
                min(cnt)
            FROM
                cnts
        )
    )