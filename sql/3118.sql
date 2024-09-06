-- https://leetcode.com/problems/friday-purchase-iii/description/


with recursive dayz as (
    select 1 as week_of_month union
    select week_of_month + 1 from dayz where week_of_month < 4
),
typez as (
    select 'Premium' as membership union
    select 'VIP'
),
combs as (
    select a.*, b.*
    from dayz a cross join typez b
),
cte as (
    select
        to_char(purchase_date, 'W')::int as week_of_month,
        b.membership,
        sum(a.amount_spend) as total_amount
    from purchases a
        inner join users b on a.user_id = b.user_id
    where 
        1=1
        and extract(dow from a.purchase_date) = 5
        and b.membership in('Premium', 'VIP')
    group by 1, 2
)

select
    a.*,
    coalesce(b.total_amount, 0) as total_amount
from combs a
    left join cte b on a.week_of_month = b.week_of_month and a.membership = b.membership
order by 1, 2;



