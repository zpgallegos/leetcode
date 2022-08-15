-- https://leetcode.com/problems/article-views-ii/

SELECT
    DISTINCT viewer_id as id
FROM
    (
        SELECT
            viewer_id,
            view_date
        FROM
            views
        GROUP BY
            viewer_id,
            view_date
        HAVING
            count(DISTINCT article_id) > 1
    ) s
ORDER BY
    viewer_id;