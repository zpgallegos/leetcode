insert into leetcode.Candidates values
(1, 'Junior', 10000),
(9, 'Junior', 10000),
(2, 'Senior', 20000),
(11, 'Senior', 20000),
(13, 'Senior', 50000),
(4, 'Senior', 40000);


with ordered as (
    select
        *, 
        row_number() over(partition by experience order by salary) as rw
    from Candidates
), cum as (
    select *, sum(salary) over(partition by experience order by rw) as spent
    from ordered
    order by experience, rw
), seniors_hired as (
    select 'Senior' as experience, max(rw) as hired, max(spent) as spent
    from cum
    where experience = 'Senior' and spent <= 70000
), juniors_hired as (
    select 'Junior' as experience, max(rw) as hired
    from cum
    where experience = 'Junior' and spent <= 70000 - (select coalesce(max(spent), 0) from seniors_hired)
)


select experience, coalesce(hired, 0) as accepted_candidates from seniors_hired
union
select experience, coalesce(hired, 0) as accepted_candidates from juniors_hired;