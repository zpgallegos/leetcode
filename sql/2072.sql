-- https://leetcode.com/problems/the-winner-university/description/


with cte as (
    select
        (select count(1) from newyork where score >= 90) as ny,
        (select count(1) from california where score >= 90) as ca
)

select 
    case 
    when ny > ca then 'New York University' 
    when ca > ny then 'California University' 
    else 'No Winner' end as winner
from cte;