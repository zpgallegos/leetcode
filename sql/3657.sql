-- https://leetcode.com/problems/find-loyal-customers/

select customer_id
from customer_transactions
group by 1
having
    1=1
    and count(1) filter(where transaction_type = 'purchase') >= 3
    and count(1) filter(where transaction_type = 'refund')::numeric / count(1) < .20
    and max(transaction_date) - min(transaction_date) >= 30
order by 1;