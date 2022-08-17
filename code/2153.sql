-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-ii/

WITH recursive bus AS (
    SELECT
        *,
        row_number() over(
            ORDER BY
                arrival_time
        ) AS bus_n,
        lag(arrival_time, 1, 0) over(
            ORDER BY
                arrival_time
        ) AS last_bus_arrival_time
    FROM
        buses
),
pass AS (
    SELECT
        bus.bus_id,
        bus.bus_n,
        bus.capacity,
        count(pas.passenger_id) AS passengers
    FROM
        bus
        LEFT JOIN Passengers pas ON pas.arrival_time <= bus.arrival_time
        AND pas.arrival_time > bus.last_bus_arrival_time
    GROUP BY
        bus.bus_id,
        bus.bus_n,
        bus.capacity
),
cte AS (
    SELECT
        bus_id,
        bus_n,
        IF(passengers <= capacity, passengers, capacity) AS picked_up,
        IF(passengers > capacity, passengers - capacity, 0) AS waiting
    FROM
        pass
    WHERE
        bus_n = 1
    UNION
    SELECT
        pass.bus_id,
        pass.bus_n,
        IF(
            passengers + waiting <= capacity,
            passengers + waiting,
            capacity
        ),
        IF(
            passengers + waiting > capacity,
            passengers + waiting - capacity,
            0
        )
    FROM
        cte
        INNER JOIN pass ON cte.bus_n + 1 = pass.bus_n
)
SELECT
    bus_id,
    picked_up AS passengers_cnt
FROM
    cte
ORDER BY
    bus_id;
