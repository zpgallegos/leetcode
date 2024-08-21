-- https://leetcode.com/problems/winning-candidate/description/

with cte as (
    select
        b.name,
        count(1) as cnt
    from vote a
        inner join candidate b on a.candidateId = b.id
    group by 1
)

select a.name
from cte a
where a.cnt = (select max(cnt) from cte);