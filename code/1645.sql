-- https://leetcode.com/problems/hopper-company-queries-ii/
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
accepted AS (
    SELECT
        MONTH(rides.requested_at) AS mnth,
        count(DISTINCT drivers.driver_id) AS drivers
    FROM
        rides
        INNER JOIN acceptedrides acc ON rides.ride_id = acc.ride_id
        INNER JOIN drivers ON acc.driver_id = drivers.driver_id
    WHERE
        year(rides.requested_at) = 2020
    GROUP BY
        MONTH(rides.requested_at)
)
SELECT
    drive.mnth AS MONTH,
    CASE
        WHEN drive.active_drivers > 0 THEN round(100 * s.drivers / drive.active_drivers, 2)
        ELSE 0
    END AS working_percentage
FROM
    drive
    INNER JOIN (
        SELECT
            *
        FROM
            accepted
        UNION
        SELECT
            mnth,
            0
        FROM
            months
        WHERE
            mnth NOT IN(
                SELECT
                    mnth
                FROM
                    accepted
            )
    ) s ON drive.mnth = s.mnth
ORDER BY
    drive.mnth