-- https://leetcode.com/problems/find-the-missing-ids/description/

with recursive seq as (
    select 1 as i union
    select i + 1 from seq where i + 1 <= (select max(customer_id) from customers)
)

select i as ids
from seq
where i not in (select customer_id from customers)
order by i;