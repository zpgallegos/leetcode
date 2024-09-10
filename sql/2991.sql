-- https://leetcode.com/problems/top-three-wineries/description/


with recursive rng as (
    select 1 as idx union
    select idx + 1 from rng where idx < 3
),
combs as (
    select distinct a.country, b.idx
    from wineries a cross join rng b
),
tabd as (
    select
        s.*,
        row_number() over win as rnk
    from (
        select
            a.country,
            a.winery,
            sum(a.points) as winery_total_points
        from wineries a
        group by 1, 2
    ) s
    window win as (partition by s.country order by s.winery_total_points desc, s.winery)
),
cte as (
    select
        a.country,
        a.idx,
        case
        when b.rnk is not null then concat(b.winery, ' (', b.winery_total_points, ')')
        else
            case
            when a.idx = 2 then 'No second winery'
            else 'No third winery'
            end
        end as label
    from combs a
        left join tabd b on a.country = b.country and a.idx = b.rnk
)

select
    a.country,
    max(case when a.idx = 1 then a.label end) as top_winery,
    max(case when a.idx = 2 then a.label end) as second_winery,
    max(case when a.idx = 3 then a.label end) as third_winery
from cte a
group by 1
order by 1;