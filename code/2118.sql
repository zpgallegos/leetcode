-- https://leetcode.com/problems/build-the-equation/
WITH recursive trms AS (
    SELECT
        concat(
            IF(factor < 0, '-', '+'),
            abs(factor),
            IF(power = 0, '', 'X'),
            IF(power IN(0, 1), '', concat('^', power))
        ) AS STRING,
        power
    FROM
        terms
)
SELECT
    concat(
        GROUP_CONCAT(
            STRING
            ORDER BY
                power DESC SEPARATOR ''
        ),
        '=0'
    ) AS equation
FROM
    trms