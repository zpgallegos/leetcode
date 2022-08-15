-- https://leetcode.com/problems/arrange-table-by-gender/
WITH cte AS (
    SELECT
        *,
        cast(
            row_number() over(
                ORDER BY
                    user_id
            ) AS float
        ) AS rw
    FROM
        Genders
    WHERE
        gender = 'female'
    UNION
    SELECT
        *,
        cast(
            row_number() over(
                ORDER BY
                    user_id
            ) AS float
        ) + 0.1 AS rw
    FROM
        Genders
    WHERE
        gender = 'other'
    UNION
    SELECT
        *,
        cast(
            row_number() over(
                ORDER BY
                    user_id
            ) AS float
        ) + 0.2 AS rw
    FROM
        Genders
    WHERE
        gender = 'male'
)
SELECT
    user_id,
    gender
FROM
    cte
ORDER BY
    rw;