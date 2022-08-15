-- https://leetcode.com/problems/running-total-for-different-genders/

select * from (
    select
        a.gender,
        a.day,
        sum(a.score_points) over(partition by a.gender order by a.day rows unbounded preceding) as total
    from Scores a
) s order by gender, s.day;