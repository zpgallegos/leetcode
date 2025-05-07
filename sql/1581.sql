-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/


select a.customer_id, count(1) as count_no_trans
from visits a
left join transactions b on a.visit_id = b.visit_id
where b.transaction_id is null
group by 1;