-- https://leetcode.com/problems/suspicious-bank-accounts/description/

with agg as (
    select
        a.account_id,
        date_trunc('month', a.day) as month,
        sum(a.amount) as total
    from transactions a
    where a.type = 'Creditor'
    group by 1, 2
),
cte as (
    select
        a.*,
        extract(month from a.month) - extract(month from lag(a.month, 1) over win) as diff
    from agg a
        inner join accounts b on a.account_id = b.account_id
    where a.total > b.max_income
    window win as (partition by a.account_id order by a.month)
)

select distinct account_id from cte where diff = 1;
    