-- https://leetcode.com/problems/loan-types/description/

with cte as (
    select distinct user_id, loan_type
    from loans
    where loan_type in('Mortgage', 'Refinance')
)

select user_id
from cte
group by user_id
having count(1) > 1
order by user_id;