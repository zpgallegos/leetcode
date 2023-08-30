-- https://leetcode.com/problems/order-two-columns-independently/
SELECT
    a.first_col,
    b.second_col
FROM
    (
        SELECT
            first_col,
            row_number() over(
                ORDER BY
                    first_col
            ) AS rw
        FROM
            data
    ) a
    INNER JOIN (
        SELECT
            second_col,
            row_number() over(
                ORDER BY
                    second_col DESC
            ) AS rw
        FROM
            data
    ) b ON a.rw = b.rw
ORDER BY
    a.rw