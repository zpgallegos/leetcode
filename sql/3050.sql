-- https://leetcode.com/problems/pizza-toppings-cost-analysis/

with cte as (
    select *, row_number() over(order by topping_name) as rw
    from toppings
)

select * from (
    select
        concat(a.topping_name, ',', b.topping_name, ',', c.topping_name) as pizza,
        a.cost + b.cost + c.cost as total_cost
    from cte a
        inner join cte b on a.rw < b.rw
        inner join cte c on b.rw < c.rw
) sub order by sub.total_cost desc, pizza;
