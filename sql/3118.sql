-- https://leetcode.com/problems/friday-purchase-iii/

with recursive weeks as (
    select 1 as week_of_month union
    select week_of_month + 1 from weeks where week_of_month < 4
), usertypes as (
    select 'VIP' as membership union
    select 'Premium' as membership
), combos as (
    select a.*, b.*
    from weeks a cross join usertypes b
), stg as (
    select
        *,
        case
        when purchase_date = '2023-11-03' then 1
        when purchase_date = '2023-11-10' then 2
        when purchase_date = '2023-11-17' then 3
        when purchase_date = '2023-11-24' then 4
        else null
        end as week_of_month
    from purchases
    where extract(dow from purchase_date) = 5
), totals as (
    select
        a.week_of_month,
        b.membership,
        sum(a.amount_spend) as total_amount
    from stg a
        inner join users b on a.user_id = b.user_id
    where b.membership in('VIP', 'Premium')
    group by
        a.week_of_month,
        b.membership
), missing as (
    select a.*, 0 as total_amount
    from combos a
        left join totals b on a.week_of_month = b.week_of_month and a.membership = b.membership
    where b.membership is null
)

select * from (
    select * from totals union
    select * from missing
) sub
order by week_of_month, membership;
