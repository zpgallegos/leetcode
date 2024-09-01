-- https://leetcode.com/problems/not-boring-movies/description/


select a.*
from cinema a
where
    1=1
    and a.id % 2 = 1
    and a.description != 'boring'
order by a.rating desc;