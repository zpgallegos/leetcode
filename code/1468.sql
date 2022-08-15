-- https://leetcode.com/problems/calculate-salaries/
WITH taxes AS (
    SELECT
        s.company_id,
        CASE
            WHEN s.mx < 1000 THEN 0.0
            WHEN s.mx <= 10000 THEN 0.24
            ELSE 0.49
        END AS tax_rate
    FROM
        (
            SELECT
                company_id,
                max(salary) AS mx
            FROM
                Salaries
            GROUP BY
                company_id
        ) s
)
SELECT
    a.company_id,
    a.employee_id,
    a.employee_name,
    round(a.salary - (b.tax_rate * a.salary)) as salary
FROM
    Salaries a
    INNER JOIN taxes b ON a.company_id = b.company_id