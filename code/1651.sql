-- https://leetcode.com/problems/hopper-company-queries-iii/
WITH recursive months AS (
    SELECT
        1 AS MONTH
    UNION
    SELECT
        MONTH + 1
    FROM
        months
    WHERE
        MONTH < 12
),
ride AS (
    SELECT
        MONTH(rides.requested_at) AS MONTH,
        sum(acc.ride_distance) AS ride_distance,
        sum(acc.ride_duration) AS ride_duration
    FROM
        rides
        INNER JOIN acceptedrides acc ON rides.ride_id = acc.ride_id
    WHERE
        year(rides.requested_at) = 2020
    GROUP BY
        MONTH(rides.requested_at)
),
all_rides AS (
    SELECT
        *
    FROM
        ride
    UNION
    SELECT
        MONTH,
        0,
        0
    FROM
        months
    WHERE
        MONTH NOT IN(
            SELECT
                MONTH
            FROM
                ride
        )
)
SELECT
    *
FROM
    (
        SELECT
            MONTH,
            round(sum(ride_distance) over win / 3, 2) AS average_ride_distance,
            round(sum(ride_duration) over win / 3, 2) AS average_ride_duration
        FROM
            all_rides window win AS (
                ORDER BY
                    MONTH ROWS BETWEEN current ROW
                    AND 2 following
            )
    ) q
WHERE
    MONTH <= 10
ORDER BY
    MONTH;