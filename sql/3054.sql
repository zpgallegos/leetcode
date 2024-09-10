-- https://leetcode.com/problems/binary-tree-nodes/description/

select distinct
    a.N,
    case
    when a.P is null then 'Root'
    when b.N is not null then 'Inner'
    else 'Leaf'
    end as Type
from tree a
    left join tree b on a.N = b.P
order by 1;