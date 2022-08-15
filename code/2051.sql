-- https://leetcode.com/problems/the-category-of-each-member-in-the-store/
WITH conv AS (
    SELECT
        a.member_id,
        100 * (
            coalesce(count(b.charged_amount), 0) / count(a.visit_id)
        ) AS conv_rate
    FROM
        Visits a
        LEFT JOIN purchases b ON a.visit_id = b.visit_id
    GROUP BY
        a.member_id
)
SELECT
    a.member_id,
    b.name,
    CASE
        WHEN a.conv_rate >= 80 THEN 'Diamond'
        WHEN a.conv_rate >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS category
FROM
    conv a
    INNER JOIN members b ON a.member_id = b.member_id
UNION
SELECT
    member_id,
    name,
    'Bronze' AS category
FROM
    Members
WHERE
    member_id NOT IN(
        SELECT
            member_id
        FROM
            conv
    )