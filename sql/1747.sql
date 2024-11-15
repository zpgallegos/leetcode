-- https://leetcode.com/problems/leetflex-banned-accounts/


select distinct a.account_id
from loginfo a
    inner join loginfo b on a.account_id = b.account_id
where
    1=1
    and a.ip_address != b.ip_address
    and b.login >= a.login
    and b.login <= a.logout;


select distinct a.account_id
from loginfo a join loginfo b
where
    1=1
    and a.account_id = b.account_id
    and a.ip_address != b.ip_address
    and b.login >= a.login
    and b.login <= a.logout;