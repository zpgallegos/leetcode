-- https://leetcode.com/problems/find-customers-with-positive-revenue-this-year/description/


select customer_id
from customers
where year = 2021
group by 1
having sum(revenue) > 0;
