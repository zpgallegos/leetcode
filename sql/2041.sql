-- https://leetcode.com/problems/accepted-candidates-from-the-interviews/

select a.candidate_id
from candidates a
    inner join rounds b on a.interview_id = b.interview_id
where a.years_of_exp >= 2
group by a.candidate_id
having sum(b.score) > 15