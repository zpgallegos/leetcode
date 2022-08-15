-- https://leetcode.com/problems/get-the-second-most-recent-activity/


with ranks as (
    select
        *,
        rank() over(partition by username order by endDate desc) as rnk
    from UserActivity
), whichRank as (
    select username, max(rnk) as mx
    from ranks
    where rnk <= 2
    group by username
)

select a.username, a.activity, a.startDate, a.endDate
from ranks a
    inner join whichRank b on a.username=b.username and a.rnk=b.mx