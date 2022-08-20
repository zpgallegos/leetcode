-- https://leetcode.com/problems/sales-by-day-of-the-week/
WITH wk AS (
    SELECT
        *,
        CASE
            weekday(orders.order_date)
            WHEN 0 THEN 'Monday'
            WHEN 1 THEN 'Tuesday'
            WHEN 2 THEN 'Wednesday'
            WHEN 3 THEN 'Thursday'
            WHEN 4 THEN 'Friday'
            WHEN 5 THEN 'Saturday'
            ELSE 'Sunday'
        END AS wkday
    FROM
        orders
),
cte AS (
    SELECT
        items.item_category,
        wk.wkday,
        sum(wk.quantity) AS qnt
    FROM
        wk
        INNER JOIN items ON wk.item_id = items.item_id
    GROUP BY
        items.item_category,
        wk.wkday
),
appnd AS (
    SELECT
        *
    FROM
        cte
    UNION
    SELECT
        i.item_category,
        d.wkday,
        0 AS qnt
    FROM
        (
            SELECT
                DISTINCT item_category
            FROM
                items
        ) i
        CROSS JOIN (
            SELECT
                'Monday' AS wkday
            UNION
            SELECT
                'Tuesday' AS wkday
            UNION
            SELECT
                'Wednesday' AS wkday
            UNION
            SELECT
                'Thursday' AS wkday
            UNION
            SELECT
                'Friday' AS wkday
            UNION
            SELECT
                'Saturday' AS wkday
            UNION
            SELECT
                'Sunday' AS wkday
        ) d
    WHERE
        (i.item_category, d.wkday) NOT IN (
            SELECT
                item_category,
                wkday
            FROM
                cte
        )
)
SELECT
    *
FROM
    (
        SELECT
            item_category AS Category,
            sum(
                CASE
                    WHEN wkday = 'Monday' THEN qnt
                    ELSE 0
                END
            ) AS Monday,
            sum(
                CASE
                    WHEN wkday = 'Tuesday' THEN qnt
                    ELSE 0
                END
            ) AS Tuesday,
            sum(
                CASE
                    WHEN wkday = 'Wednesday' THEN qnt
                    ELSE 0
                END
            ) AS Wednesday,
            sum(
                CASE
                    WHEN wkday = 'Thursday' THEN qnt
                    ELSE 0
                END
            ) AS Thursday,
            sum(
                CASE
                    WHEN wkday = 'Friday' THEN qnt
                    ELSE 0
                END
            ) AS Friday,
            sum(
                CASE
                    WHEN wkday = 'Saturday' THEN qnt
                    ELSE 0
                END
            ) AS Saturday,
            sum(
                CASE
                    WHEN wkday = 'Sunday' THEN qnt
                    ELSE 0
                END
            ) AS Sunday
        FROM
            appnd
        GROUP BY
            item_category
    ) s
ORDER BY
    s.Category;