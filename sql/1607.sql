-- https://leetcode.com/problems/sellers-with-no-sales/description/

select seller_name
from seller
where seller_id not in(
    select distinct seller_id 
    from orders 
    where sale_date between '2020-01-01' and '2020-12-31'
)
order by 1;