-- https://leetcode.com/problems/arrange-table-by-gender/


with ordered as (
    select
        a.*,
        (row_number() over win) + if(a.gender = 'female', 0, if(a.gender = 'other', .1, .2)) as idx
    from genders a
    window win as (partition by a.gender order by a.user_id)
)

select a.user_id, a.gender
from ordered a
order by idx;
