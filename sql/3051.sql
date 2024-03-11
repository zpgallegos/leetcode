-- https://leetcode.com/problems/find-candidates-for-data-scientist-position/


select py.candidate_id
from candidates py
    inner join candidates tab on py.candidate_id = tab.candidate_id
    inner join candidates post on py.candidate_id = post.candidate_id
where
    py.skill = 'Python' and
    tab.skill = 'Tableau' and
    post.skill = 'PostgreSQL'
order by py.candidate_id;