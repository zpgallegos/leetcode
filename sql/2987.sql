-- https://leetcode.com/problems/find-expensive-cities/

with grpd as (
    select city, avg(price) as price
    from listings
    group by city
)

select city
from grpd
where price > (select avg(price) from listings)
order by city;