

select
    a.name as warehouse_name,
    sum(a.units * b.Width * b.Length * b.Height) as volume

from Warehouse a
    inner join Products b on a.product_id = b.product_id

group by a.name;