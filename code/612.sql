-- https://leetcode.com/problems/shortest-distance-in-a-plane/
WITH points AS (
    SELECT
        *,
        row_number() over() AS rw
    FROM
        point2d
)
SELECT
    round(min(dist), 2) AS shortest
FROM
    (
        SELECT
            sqrt(power(b.x - a.x, 2) + power(b.y - a.y, 2)) AS dist
        FROM
            points a
            CROSS JOIN points b
        WHERE
            a.rw < b.rw
    ) s