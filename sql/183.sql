-- https://leetcode.com/problems/customers-who-never-order/description/

select a.name as Customers
from customers a
    left join orders b on a.id = b.customerId
where b.customerId is null