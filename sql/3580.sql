-- https://leetcode.com/problems/find-consistently-improving-employees/description/

with windowed as (
    select
        a.employee_id,
        a.rating,
        row_number() over win_desc as rn,
        lead(a.rating, 1) over win_desc as rating_1,
        lead(a.rating, 2) over win_desc as rating_2
    from performance_reviews a
    window win_desc as (partition by a.employee_id order by a.review_date desc)
),

final as (
    select
        a.employee_id,
        b.name,
        a.rating - a.rating_2 as improvement_score
    from windowed a
    inner join employees b on a.employee_id = b.employee_id
    where
        1=1
        and a.rn = 1
        and a.rating > a.rating_1
        and a.rating_1 > a.rating_2
)

select * from final order by improvement_score desc, name;