-- https://leetcode.com/problems/find-cities-in-each-state-ii/description/

with aggd as (
    select
        a.state,
        string_agg(a.city, ', ' order by a.city) as cities,
        sum(case when substring(a.state, 1, 1) = substring(a.city, 1, 1) then 1 else 0 end) as matching_letter_count
    from cities a
    group by 1
    having count(1) >= 3
)

select * from aggd where matching_letter_count > 0 order by 3 desc, 1;


