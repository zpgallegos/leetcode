-- https://leetcode.com/problems/reported-posts/

select
    extra as report_reason,
    count(distinct post_id) as report_count
from actions
where
    "action" = 'report' and
    action_date = '2019-07-04'
    -- action_date = cast(dateadd(day, -1, getdate()) as date)
group by extra;