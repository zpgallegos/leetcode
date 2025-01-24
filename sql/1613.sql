-- https://leetcode.com/problems/find-the-missing-ids/description/


with recursive seq as (
    select 1 as id
    union
    select id + 1 from seq where id < (select max(customer_id) from customers)
)

select a.id as ids
from seq a
    left join customers b on a.id = b.customer_id
where b.customer_id is null
order by 1;