-- https://leetcode.com/problems/count-apples-and-oranges/
SELECT
    sum(apples) AS apple_count,
    sum(oranges) AS orange_count
FROM
    (
        SELECT
            a.apple_count + coalesce(b.apple_count, 0) AS apples,
            a.orange_count + coalesce(b.orange_count, 0) AS oranges
        FROM
            boxes a
            LEFT JOIN chests b ON a.chest_id = b.chest_id
    ) s