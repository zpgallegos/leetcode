-- https://leetcode.com/problems/big-countries/description/


select
    a.name,
    a.population,
    a.area
from world a
where
    a.area >= 3000000 or
    a.population >= 25000000;