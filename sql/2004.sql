-- https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/description/


with ordered as (
    select
        a.*,
        row_number() over win as cum_hired,
        sum(a.salary) over win as cum_spent
    from candidates a
    window win as (partition by a.experience order by a.salary)
),
seniors as (
    select
        'Senior' as experience,
        coalesce(max(a.cum_hired), 0) as accepted_candidates,
        coalesce(max(a.cum_spent), 0) as senior_spent
    from ordered a
    where
        1=1 
        and a.experience = 'Senior'
        and a.cum_spent <= 70000
),
juniors as (
    select
        'Junior' as experience,
        coalesce(max(a.cum_hired), 0) as accepted_candidates
    from ordered a
    where
        1=1
        and experience = 'Junior'
        and a.cum_spent <= 70000 - (select senior_spent from seniors)
)

select experience, accepted_candidates from seniors union
select * from juniors;