-- https://leetcode.com/problems/ads-performance/

with cte as (
    select
        ad_id,
        sum(if(action = "Clicked", 1, 0)) as clicks,
        sum(if(action = "Viewed", 1, 0)) as viewed
    from ads
    group by ad_id
)

select
    ad_id,
    case
    when clicks + viewed = 0 then 0
    else round((clicks / (clicks + viewed)) * 100, 2)
    end as ctr
from cte
order by ctr desc, ad_id;