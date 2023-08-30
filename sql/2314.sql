-- https://leetcode.com/problems/the-first-day-of-the-maximum-recorded-degree-in-each-city/
SELECT
    a.city_id,
    a.day,
    a.degree
FROM
    weather a
    INNER JOIN (
        SELECT
            a.city_id,
            min(a.day) AS mn
        FROM
            weather a
            INNER JOIN (
                SELECT
                    city_id,
                    max(degree) AS mx
                FROM
                    weather
                GROUP BY
                    city_id
            ) b ON a.city_id = b.city_id
            AND a.degree = b.mx
        GROUP BY
            city_id
    ) s ON a.city_id = s.city_id
    AND a.day = s.mn
ORDER BY
    a.city_id;