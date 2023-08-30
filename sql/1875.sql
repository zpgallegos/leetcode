-- https://leetcode.com/problems/group-employees-of-the-same-salary/
SELECT
    *
FROM
    (
        SELECT
            employee_id,
            name,
            salary,
            dense_rank() over(
                ORDER BY
                    salary
            ) AS team_id
        FROM
            Employees
        WHERE
            salary IN(
                SELECT
                    salary
                FROM
                    Employees
                GROUP BY
                    salary
                HAVING
                    count(1) > 1
            )
    ) q
ORDER BY
    team_id,
    employee_id;