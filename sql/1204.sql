-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/
WITH cum AS (
    SELECT
        turn,
        sum(weight) over(
            ORDER BY
                turn
        ) AS cum_weight

    FROM
        Queue
)


SELECT
    person_name
FROM
    Queue
WHERE
    turn = (
        SELECT
            max(turn)
        FROM
            cum
        WHERE
            cum_weight <= 1000
    )