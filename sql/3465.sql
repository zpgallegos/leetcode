-- https://leetcode.com/problems/find-products-with-valid-serial-numbers/description/

select *
from products
where description ~ '\mSN\d{4}-\d{4}\M'
order by product_id;