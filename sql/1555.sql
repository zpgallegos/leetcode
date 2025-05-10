-- https://leetcode.com/problems/bank-account-summary/description/

with

cte as (
    select paid_by as user_id, -amount as amount from transactions union all
    select paid_to as user_id, amount from transactions
),

agg as (
    select user_id, sum(amount) as bal
    from cte
    group by 1
)

select
    a.user_id,
    a.user_name,
    a.credit + coalesce(b.bal, 0) as credit,
    case when a.credit + coalesce(b.bal, 0) < 0 then 'Yes' else 'No' end as credit_limit_breached
from users a
left join agg b on a.user_id = b.user_id
