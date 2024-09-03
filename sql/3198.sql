-- https://leetcode.com/problems/find-cities-in-each-state/description/

select
    a.state,
    group_concat(a.city order by a.city separator ', ') as cities 
from cities a
group by 1;