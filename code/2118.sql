-- https://leetcode.com/problems/build-the-equation/


select
    concat(
        group_concat(term order by power desc separator ''),
        '=0'
    ) as equation

from (
    select
        power,
        concat(
            if(factor < 0, '-', '+'),
            abs(factor),
            case power
            when 0 then ''
            when 1 then 'X'
            else concat('X^', power)
            end
        ) as term

    from terms
) q