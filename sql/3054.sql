-- https://leetcode.com/problems/binary-tree-nodes/

select distinct
    a.N,
    case
    when a.P is null then 'Root'
    when b.P is null then 'Leaf'
    else 'Inner'
    end as Type
from tree a
    left join tree b on a.N = b.P
order by a.N;