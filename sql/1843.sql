-- https://leetcode.com/problems/suspicious-bank-accounts/
WITH income AS (
    SELECT
        a.account_id,
        cast(date_format(a.day, '%Y-%m-01') as date) AS MONTH,
        sum(amount) AS income
    FROM
        Transactions a
    WHERE
        TYPE = 'Creditor'
    GROUP BY
        a.account_id,
        cast(date_format(a.day, '%Y-%m-01') as date)
),
cte AS (
    SELECT
        a.account_id,
        a.month,
        IF(a.income > b.max_income, 1, 0) AS exceeds
    FROM
        income a
        INNER JOIN accounts b ON a.account_id = b.account_id
)
SELECT
    DISTINCT account_id
FROM
    (
        SELECT
            account_id,
            month,
            exceeds,
            lag(exceeds, 1) over win AS last_exceeds,
            lag(month, 1) over win as last_month
        FROM
            cte
        window win as (partition by account_id order by month)
    ) q
WHERE
    exceeds
    AND last_exceeds
    and date_sub(month, interval 1 month) = last_month;


-- fixing this dude's code

WITH cte1 AS (
    SELECT
        account_id,
        DATE_FORMAT(day, "%Y-%m-01") date,
        SUM(amount) total_income
    FROM
        Transactions
    WHERE
        type = "Creditor"
    GROUP BY
        1,
        2
),
cte2 AS (
    SELECT 
        c.*,
        a.max_income,
        RANK() OVER (PARTITION BY account_id ORDER BY date) n
    FROM 
        cte1 c
    INNER JOIN
        Accounts a
    USING
        (account_id)
    WHERE
        total_income > a.max_income 
)

SELECT DISTINCT
    account_id
FROM
    cte2
GROUP BY
    account_id,
    date_sub(date, interval n month)
HAVING
   COUNT(*) >= 2
    