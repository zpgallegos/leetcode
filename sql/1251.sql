-- https://leetcode.com/problems/average-selling-price/description/


with res as (
    select
        a.product_id,
        round(sum(a.units * b.price) / sum(a.units), 2) as average_price
    from unitssold a
        inner join prices b on a.product_id = b.product_id
    where a.purchase_date between b.start_date and b.end_date
    group by 1
)

select * from res 

union

select distinct product_id, 0 
from prices
where product_id not in(select product_id from res);


-- this one-lines it but is kind of a hack lol
-- coalesce to 1 is to avoid a divide by zero in the event there was none of a product sold
-- numerator will be zero in that case anyway

select
    a.product_id,
    round(sum(a.price * coalesce(b.units, 0)) / coalesce(sum(b.units), 1), 2) as average_price
from prices a
    left join unitssold b on 
        1=1
        and a.product_id = b.product_id
        and b.purchase_date between a.start_date and a.end_date
group by 1;