-- https://leetcode.com/problems/hopper-company-queries-i/
WITH recursive months AS (
    SELECT
        1 AS mnth
    UNION
    SELECT
        mnth + 1
    FROM
        months
    WHERE
        mnth < 12
),
drive AS (
    SELECT
        months.mnth,
        coalesce(
            max(q.n_drivers) over(
                ORDER BY
                    months.mnth
            ),
            0
        ) AS active_drivers
    FROM
        months
        LEFT JOIN (
            SELECT
                mnth,
                max(n_drivers) AS n_drivers
            FROM
                (
                    SELECT
                        join_date,
                        MONTH(join_date) AS mnth,
                        count(1) over(
                            ORDER BY
                                join_date
                        ) AS n_drivers
                    FROM
                        drivers
                ) s
            WHERE
                year(join_date) = 2020
            GROUP BY
                mnth
        ) q ON months.mnth = q.mnth
),
accept AS (
    SELECT
        MONTH(rides.requested_at) AS mnth,
        count(acc.ride_id) AS acc
    FROM
        rides
        LEFT JOIN acceptedrides acc ON rides.ride_id = acc.ride_id
    WHERE
        year(rides.requested_at) = 2020
    GROUP BY
        MONTH(rides.requested_at)
),
rides AS (
    SELECT
        *
    FROM
        accept
    UNION
    SELECT
        mnth,
        0 AS acc
    FROM
        months
    WHERE
        mnth NOT IN(
            SELECT
                mnth
            FROM
                accept
        )
)
SELECT
    drive.mnth AS MONTH,
    drive.active_drivers,
    rides.acc AS accepted_rides
FROM
    drive
    INNER JOIN rides ON drive.mnth = rides.mnth
ORDER BY
    drive.mnth