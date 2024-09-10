-- https://leetcode.com/problems/friday-purchases-i/description/

select
    to_char(a.purchase_date, 'W')::int as week_of_month,
    a.purchase_date,
    sum(a.amount_spend) as total_amount
from purchases a
where extract(dow from a.purchase_date) = 5
group by 1, 2
order by 1;

