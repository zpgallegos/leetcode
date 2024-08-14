-- https://leetcode.com/problems/running-total-for-different-genders/


select
    a.gender,
    a.day,
    sum(a.score_points) over win as total
from scores a
window win as (partition by a.gender order by a.day)
order by a.gender, a.day;
