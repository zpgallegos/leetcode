-- https://leetcode.com/problems/monthly-transactions-ii/

with trans as (
    select a.*, date_format(a.trans_date, '%Y-%m') as month
    from transactions a
    where a.state = 'approved'
),
chgs as (
    select
        b.id,
        b.country,
        date_format(a.trans_date, '%Y-%m') as month,
        b.amount
    from chargebacks a
        inner join transactions b on a.trans_id = b.id
),
app as (
    select a.month, a.country, 'ac' as stat, count(1) as val
    from trans a
    group by 1, 2, 3

    union

    select a.month, a.country, 'aa' as stat, sum(a.amount) as val
    from trans a
    group by 1, 2, 3
),
chg as (
    select a.month, a.country, 'cc' as stat, count(1) as val
    from chgs a
    group by 1, 2, 3

    union

    select a.month, a.country, 'ca' as stat, sum(a.amount) as val
    from chgs a
    group by 1, 2, 3
)

select
    a.month,
    a.country,
    max(case when a.stat = 'ac' then a.val else 0 end) as approved_count,
    max(case when a.stat = 'aa' then a.val else 0 end) as approved_amount,
    max(case when a.stat = 'cc' then a.val else 0 end) as chargeback_count,
    max(case when a.stat = 'ca' then a.val else 0 end) as chargeback_amount
from (
    select * from app union
    select * from chg
) a
group by 1, 2;