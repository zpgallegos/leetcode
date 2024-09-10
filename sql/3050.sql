-- https://leetcode.com/problems/pizza-toppings-cost-analysis/description/

with cte as (
    select 
        a.*,
        row_number() over win as rn
    from toppings a
    window win as (order by a.topping_name)
)

select
    concat(a.topping_name, ',', b.topping_name, ',', c.topping_name) as pizza,
    round(a.cost + b.cost + c.cost, 2) as total_cost
from cte a
    inner join cte b on a.rn < b.rn
    inner join cte c on b.rn < c.rn
order by 2 desc, 1;

