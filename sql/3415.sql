-- https://leetcode.com/problems/find-products-with-three-consecutive-digits/description/

select a.*
from products a
where a.name regexp '(^|[^\\d])\\d{3}($|[^\\d])'
order by 1;
