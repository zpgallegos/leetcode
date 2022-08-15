-- https://leetcode.com/problems/leetflex-banned-accounts/


with a as (
    select
        *,
        lag(a.logout, 1) over(partition by a.account_id order by a.login) as last_logout,
        lag(a.ip_address, 1) over(partition by a.account_id order by a.login) as last_ip
    
    from LogInfo a
)

select distinct a.account_id
from a
where a.login <= a.last_logout and a.ip_address != a.last_ip;