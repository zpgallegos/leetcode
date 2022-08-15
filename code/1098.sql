-- https://leetcode.com/problems/unpopular-books/
SELECT
    a.book_id,
    a.name
FROM
    Books a
    LEFT JOIN Orders b ON a.book_id = b.book_id
WHERE
    a.available_from <= '2019-05-23'
GROUP BY
    a.book_id,
    a.name
HAVING
    sum(
        CASE
            WHEN b.dispatch_date IS NULL
            OR b.dispatch_date < '2018-06-23' THEN 0
            ELSE b.quantity
        END
    ) < 10
    /* better ... */
SELECT
    book_id,
    name
FROM
    books
WHERE
    available_from <= '2019-05-23'
    AND book_id NOT IN(
        SELECT
            book_id
        FROM
            orders
        WHERE
            dispatch_date >= '2018-06-23'
        GROUP BY
            book_id
        HAVING
            sum(quantity) >= 10
    )