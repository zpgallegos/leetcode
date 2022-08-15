

select
    a.product_id,
    round(sum(a.units * b.price) / sum(a.units), 2) as average_price

from UnitsSold a
    inner join Prices b on a.product_id = b.product_id

where a.purchase_date between b.start_date and b.end_date

group by a.product_id;