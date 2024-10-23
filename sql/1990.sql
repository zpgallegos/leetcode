-- https://leetcode.com/problems/count-the-number-of-experiments/description/

with combs as (
    select distinct a.platform, b.experiment_name
    from experiments a cross join experiments b
),
tbl as (
    select
        a.platform,
        a.experiment_name,
        count(1) as cnt
    from experiments a
    group by 1, 2
)

select
    a.*,
    coalesce(b.cnt, 0) as num_experiments
from combs a
    left join tbl b on a.platform = b.platform and a.experiment_name = b.experiment_name
order by 1, 2;