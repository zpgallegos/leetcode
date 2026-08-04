-- https://leetcode.com/problems/most-common-course-pairs/

with high_performing as (
    select user_id
    from course_completions
    group by 1
    having
        count(1) >= 5
        and avg(course_rating) >= 4
),

ordered as (
    select
        a.course_name as first_course,
        lead(course_name) over(partition by a.user_id order by a.completion_date) as second_course
    from course_completions a
    inner join high_performing b on a.user_id = b.user_id
)

select
    first_course,
    second_course,
    count(1) as transition_count
from ordered
where second_course is not null
group by 1, 2
order by 3 desc, lower(first_course), lower(second_course);


