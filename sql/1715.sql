-- https://leetcode.com/problems/count-apples-and-oranges/


select
    coalesce(sum(a.apple_count), 0) + coalesce(sum(b.apple_count), 0) as apple_count,
    coalesce(sum(a.orange_count), 0) + coalesce(sum(b.orange_count), 0) as orange_count
from boxes a
    left join chests b on a.chest_id = b.chest_id