select
    a.product_id,
    a.product_name
from
    Product a
    inner join Sales b on a.product_id = b.product_id
group by
    a.product_id
having
    min(b.sale_date) >= '2019-01-01'
    and max(b.sale_date) <= '2019-03-31'