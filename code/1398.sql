

select customer_id, customer_name
from Customers
where
    (customer_id, 'A') in(select customer_id, product_name from Orders) and
    (customer_id, 'B') in(select customer_id, product_name from Orders) and
    (customer_id, 'C') not in(select customer_id, product_name from Orders)


select a.customer_id, a.customer_name
from Customers a left join Orders b on a.customer_id = b.customer_id
group by a.customer_id
having 
    sum(b.product_name = 'A') and 
    sum(b.product_name = 'B') and 
    not sum(b.product_name = 'C');