-- https://leetcode.com/problems/arrange-table-by-gender/

with cte as (
    select
        a.*,
        row_number() over win +
        case
        when a.gender = 'other' then .01
        when a.gender = 'male' then .1
        else 0
        end as idx
    from genders a
    window win as (partition by a.gender order by a.user_id)
)

select user_id, gender
from cte
order by idx;
