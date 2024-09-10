-- https://leetcode.com/problems/find-candidates-for-data-scientist-position/description/

select candidate_id
from candidates
where skill in('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(1) = 3
order by 1;