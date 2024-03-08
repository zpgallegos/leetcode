-- https://leetcode.com/problems/top-three-wineries/

declare @max_rank int = 3;

with rank_range as ( 
    -- recursive
    select 1 as rnk
    union all
    select rnk + 1 from rank_range where rnk < @max_rank
), idx as (
    select sub.country, rank_range.rnk
    from (
        select distinct country
        from wineries
    ) sub cross join rank_range
), grpd as (
    select 
        *,
        row_number() over(partition by country order by winery_total_points desc, winery) as rnk
    from (
        select country, winery, sum(points) as winery_total_points
        from wineries
        group by country, winery
    ) sub
), filled as (
    select * from grpd union
    select
        a.country,
        case
        when a.rnk = 2 then 'No second winery'
        when a.rnk = 3 then 'No third winery'
        end as winery,
        null as winery_total_points,
        a.rnk
    from idx a
        left join grpd b on a.country = b.country and a.rnk = b.rnk
    where b.country is null
), labeled as (
    select
        *,
        case
        when rnk = 1 then 'top_winery'
        when rnk = 2 then 'second_winery'
        when rnk = 3 then 'third_winery'
        end as rnk_label,
        case
        when winery_total_points is null then winery
        else concat(winery, ' (', winery_total_points, ')')
        end as label
    from filled
)

select * from (
    select 
        country,
        max(case when rnk_label = 'top_winery' then label else null end) as top_winery,
        max(case when rnk_label = 'second_winery' then label else null end) as second_winery,
        max(case when rnk_label = 'third_winery' then label else null end) as third_winery
    from labeled
    group by country
) sub order by country;