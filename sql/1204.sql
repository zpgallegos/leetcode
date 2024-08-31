-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/

with cte as (
    select
        a.*,
        sum(a.weight) over win as running
    from queue a
    window win as (order by a.turn rows between unbounded preceding and current row)
)

select person_name 
from cte 
where turn = (select max(turn) from cte where running <= 1000);