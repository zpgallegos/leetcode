-- https://leetcode.com/problems/find-expensive-cities/description/

select a.city
from listings a
group by 1
having avg(a.price) > (select avg(price) from listings)
order by 1;