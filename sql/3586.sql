-- https://leetcode.com/problems/find-covid-recovery-patients/

with pos as (
    select patient_id, min(test_date) as first_pos_date
    from covid_tests
    where result = 'Positive'
    group by 1
),

out as (
    select
        a.patient_id,
        min(b.test_date) - a.first_pos_date as recovery_time
    from pos a
    inner join covid_tests b on
        a.patient_id = b.patient_id
        and b.test_date >= a.first_pos_date
        and b.result = 'Negative'
    group by a.patient_id, a.first_pos_date
)

select
    a.patient_id,
    b.patient_name,
    b.age,
    a.recovery_time
from out a
inner join patients b on a.patient_id = b.patient_id
order by 4, 2;