-- https://leetcode.com/problems/new-users-daily-count/
WITH first_logins AS (
    SELECT
        a.user_id,
        a.activity_date
    FROM
        Traffic a
        INNER JOIN (
            SELECT
                user_id,
                activity,
                min(activity_date) AS first_login
            FROM
                Traffic
            WHERE
                activity = 'login'
            GROUP BY
                user_id,
                activity
        ) b ON a.user_id = b.user_id
        AND a.activity = b.activity
        AND a.activity_date = b.first_login
)
SELECT
    activity_date AS login_date,
    count(DISTINCT user_id) AS user_count -- user could've logged in on first day multiple times
FROM
    first_logins
WHERE
    activity_date >= date_sub('2019-06-30', INTERVAL 90 DAY)
GROUP BY
    activity_date