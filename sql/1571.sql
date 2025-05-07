-- https://leetcode.com/problems/warehouse-manager/description/

select
    a.name as warehouse_name,
    sum(a.units * b.width * b.length * b.height) as volume
from warehouse a
inner join products b on a.product_id = b.product_id
group by 1;