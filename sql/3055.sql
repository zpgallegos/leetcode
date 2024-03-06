-- https://leetcode.com/problems/top-percentile-fraud/

with cnts as (
    select state, count(1) as cnt
    from fraud
    group by state
),
rnk as (
    select *,
        rank() over(partition by state order by fraud_score desc) as rnk
    from fraud
)

select
    a.policy_id,
    a.state,
    a.fraud_score
from rnk a inner join cnts b on a.state = b.state
where rnk <= ceiling(b.cnt / 20.0)
order by state, fraud_score desc, policy_id;


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
