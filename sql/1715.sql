-- https://leetcode.com/problems/count-apples-and-oranges/description/


select
    sum(a.apple_count) + sum(coalesce(b.apple_count, 0)) as apple_count,
    sum(a.orange_count) + sum(coalesce(b.orange_count, 0)) as orange_count
from boxes a
    left join chests b on a.chest_id = b.chest_id