-- https://leetcode.com/problems/number-of-times-a-driver-was-a-passenger/
SELECT
    a.driver_id,
    count(b.ride_id) AS cnt
FROM
    (
        SELECT
            DISTINCT driver_id
        FROM
            Rides
    ) a
    LEFT JOIN Rides b ON a.driver_id = b.passenger_id
GROUP BY
    a.driver_id