-- https://leetcode.com/problems/the-airport-with-the-most-traffic/
WITH fl AS (
    SELECT
        departure_airport AS airport_id,
        flights_count
    FROM
        Flights
    UNION
    ALL
    SELECT
        arrival_airport AS airport_id,
        flights_count
    FROM
        Flights
),
cnts AS (
    SELECT
        airport,
        sum(flights_count) AS cnt
    FROM
        fl
    GROUP BY
        airport
)
SELECT
    airport_id
FROM
    cnts
WHERE
    cnt = (
        SELECT
            max(cnt)
        FROM
            cnts
    )