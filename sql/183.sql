
select name as Customers

from Customers a left join Orders b on a.id = b.customerId

where b.id is null