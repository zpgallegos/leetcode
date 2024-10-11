-- https://leetcode.com/problems/account-balance/description/

select
    a.account_id,
    a.day,
    sum((case when a.type = 'Withdraw' then -1 else 1 end) * a.amount) over win as balance
from transactions a
window win as (
    partition by a.account_id 
    order by a.day
    rows between unbounded preceding and current row
)
order by 1, 2;