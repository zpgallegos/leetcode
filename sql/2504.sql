-- https://leetcode.com/problems/concatenate-the-name-and-the-profession/description/

select
    a.person_id,
    concat(a.name, '(', substring(a.profession, 1, 1), ')') as name
from person a
order by 1 desc;


-- https://leetcode.com/problems/concatenate-the-name-and-the-profession/description/


select person_id, concat(name, '(', left(profession, 1), ')') as name
from person
order by person_id desc;