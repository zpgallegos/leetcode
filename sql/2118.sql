-- https://leetcode.com/problems/build-the-equation/description/

with cte as (
    select
        a.*,
        concat(
            case when a.factor > 0 then '+' else '-' end,
            abs(a.factor)::varchar,
            case
            when a.power = 0 then ''
            when a.power = 1 then 'X'
            else concat('X^', a.power::varchar)
            end
        ) as term
    from terms a
)

select concat(string_agg(term, '' order by power desc), '=0') as equation
from cte;

-- https://leetcode.com/problems/build-the-equation/


with cte as (
    select
        a.power,
        concat(
            if(a.factor < 0, '-', '+'),
            abs(a.factor),
            if(a.power > 0, if(a.power = 1, 'X', concat('X^', a.power)), '')
        ) as term
    from terms a
)

select concat(group_concat(a.term order by a.power desc separator ''), '=0') as equation
from cte a