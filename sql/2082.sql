-- https://leetcode.com/problems/the-number-of-rich-customers/description/

select count(distinct customer_id) as rich_count
from store
where amount > 500;