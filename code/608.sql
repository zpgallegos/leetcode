-- https://leetcode.com/problems/tree-node/

select distinct
    a.id,
    case
    when a.p_id is null then 'Root'
    when b.p_id is not null then 'Inner'
    else 'Leaf'
    end as type

from tree a
    left join tree b on a.id = b.p_id

order by a.id;
