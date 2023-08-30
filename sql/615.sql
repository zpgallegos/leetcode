-- https://leetcode.com/problems/average-salary-departments-vs-company/
WITH cte AS (
    SELECT
        emp.department_id,
        date_format(sal.pay_date, '%Y-%m') AS pay_month,
        sal.amount
    FROM
        salary sal
        INNER JOIN Employee emp ON sal.employee_id = emp.employee_id
),
dep_avg AS (
    SELECT
        department_id,
        pay_month,
        avg(amount) AS dep_avg
    FROM
        cte
    GROUP BY
        department_id,
        pay_month
),
month_avg AS (
    SELECT
        pay_month,
        avg(amount) AS month_avg
    FROM
        cte
    GROUP BY
        pay_month
)
SELECT
    a.pay_month,
    a.department_id,
    CASE
        WHEN a.dep_avg > b.month_avg THEN 'higher'
        WHEN a.dep_avg = b.month_avg THEN 'same'
        ELSE 'lower'
    END AS comparison
FROM
    dep_avg a
    INNER JOIN month_avg b ON a.pay_month = b.pay_month