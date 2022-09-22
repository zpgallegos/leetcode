-- https://leetcode.com/problems/shortest-distance-in-a-line/

select min(abs(a.x - b.x)) as shortest
from point a cross join point b
where a.x != b.x