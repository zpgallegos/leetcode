-- https://leetcode.com/problems/top-percentile-fraud/description/


with cte as (
    select
        a.*,
        rank() over (partition by a.state order by a.fraud_score desc) as rnk,
        count(1) over (partition by a.state) as state_count
    from fraud a
)

select
    a.policy_id,
    a.state,
    a.fraud_score
from cte a
where a.rnk <= ceiling(a.state_count / 20.0)
order by 2, 3 desc, 1;


/* doesn't work with the adversarial ties in the test cases */

with cte as (
    select
        *,
        ntile(20) over(partition by state order by fraud_score desc) as grp
    from fraud
)

select policy_id, state, fraud_score
from cte
where grp = 1
order by state, fraud_score desc, policy_id;
