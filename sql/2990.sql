-- https://leetcode.com/problems/loan-types/description/

select user_id
from loans
where loan_type in('Refinance', 'Mortgage')
group by 1
having count(distinct loan_type) = 2
order by 1;