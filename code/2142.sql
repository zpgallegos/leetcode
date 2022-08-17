-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-i/
WITH cte AS (
    SELECT
        bus_id,
        arrival_time AS bus_time,
        coalesce(
            lag(arrival_time, 1) over(
                ORDER BY
                    arrival_time
            ),
            0
        ) AS last_bus
    FROM
        buses
)
SELECT
    *
FROM
    (
        SELECT
            bus_id,
            count(b.passenger_id) AS passengers_cnt
        FROM
            cte a
            LEFT JOIN Passengers b ON b.arrival_time > a.last_bus
            AND b.arrival_time <= a.bus_time
        GROUP BY
            bus_id
    ) s
ORDER BY
    bus_id;