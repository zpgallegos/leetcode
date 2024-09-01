-- https://leetcode.com/problems/queries-quality-and-percentage/description/


select
    a.query_name,
    round(avg(a.rating / a.position), 2) as quality,
    round(avg(if(a.rating < 3, 1, 0)) * 100, 2) as poor_query_percentage
from queries a
where a.query_name is not null -- stupid ass test case
group by 1;