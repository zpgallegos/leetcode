-- https://leetcode.com/problems/the-winner-university/description/


with cte as (
    select 
        (select sum(case when score >= 90 then 1 else 0 end) as exc from newyork) as ny,
        (select sum(case when score >= 90 then 1 else 0 end) as exc from california) as ca
)

select case when ny > ca then 'New York University' when ca > ny then 'California University' else 'No Winner' end as winner
from cte