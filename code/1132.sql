-- https://leetcode.com/problems/reported-posts-ii/
SELECT
    round(avg(day_prop) * 100, 2) AS average_daily_percent
FROM
    (
        SELECT
            spam.action_date,
            avg(b.remove_date IS NOT NULL) AS day_prop
        FROM
            (
                SELECT
                    DISTINCT post_id,
                    action_date
                FROM
                    actions
                WHERE
                    extra = 'spam'
            ) spam
            LEFT JOIN removals b ON spam.post_id = b.post_id
        GROUP BY
            spam.action_date
    ) s