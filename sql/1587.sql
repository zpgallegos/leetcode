-- https://leetcode.com/problems/bank-account-summary-ii/description/

with

agg as (
    select account, sum(amount) as balance
    from transactions
    group by 1
    having sum(amount) > 10000
)

select b.name, a.balance
from agg a
inner join users b on a.account = b.account;