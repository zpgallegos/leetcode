-- https://leetcode.com/problems/find-the-missing-ids/

with recursive nums as (
    select 1 as id
    union
    select id + 1
    from nums
    where id + 1 <= (select max(customer_id) from Customers)
)

select id as ids from nums where id not in(select customer_id from Customers);