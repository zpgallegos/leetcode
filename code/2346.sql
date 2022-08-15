-- https://leetcode.com/problems/compute-the-rank-as-a-percentage/
WITH ranked AS (
    SELECT
        *,
        rank() over(
            PARTITION by department_id
            ORDER BY
                mark DESC
        ) AS rnk
    FROM
        students
)
SELECT
    a.student_id,
    a.department_id,
    round(
        CASE
            WHEN s.n > 1 THEN ((a.rnk - 1) * 100) / (s.n - 1)
            ELSE 0
        END,
        2
    ) AS percentage
FROM
    ranked a
    INNER JOIN (
        SELECT
            department_id,
            count(1) AS n
        FROM
            Students
        GROUP BY
            department_id
    ) s ON a.department_id = s.department_id