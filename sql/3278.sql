-- https://leetcode.com/problems/find-candidates-for-data-scientist-position-ii/description/

with cnts as (
    select project_id, count(1) as skill_count
    from projects
    group by 1
),
cte as (
    select
        a.project_id,
        b.candidate_id,
        count(1) as skill_count,
        100 + sum(if(a.importance < b.proficiency, 10, if(a.importance > b.proficiency, -5, 0))) as score
    from projects a
        inner join candidates b on a.skill = b.skill
    group by 1, 2
),
res as (
    select
        a.*,
        row_number() over(partition by a.project_id order by a.score desc, a.candidate_id) as rnk
    from cte a
        inner join cnts b on a.project_id = b.project_id and a.skill_count = b.skill_count
)

select project_id, candidate_id, score
from res
where rnk = 1
order by 1;



