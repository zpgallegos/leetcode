-- https://leetcode.com/problems/number-of-transactions-per-visit/description/

with recursive trans as (
    select a.*, row_number() over() as trans_id
    from transactions a
),
cte as (
    select
        a.user_id,
        a.visit_date,
        count(distinct trans_id) as ntrans
    from visits a
        left join trans b on a.user_id = b.user_id and a.visit_date = b.transaction_date
    group by 1, 2
),
cnts as (
    select
        a.ntrans,
        count(1) as cnt
    from cte a
    group by a.ntrans
),
seq as (
    select 0 as i union
    select i + 1 from seq where i + 1 <= (select max(ntrans) from cnts)
),
fill as (
    select a.i as ntrans, 0 as cnt
    from seq a
    where a.i not in(select ntrans from cnts)
)

select
    sub.ntrans as transactions_count,
    sub.cnt as visits_count
from (
    select * from cnts union
    select * from fill
) sub
order by 1;
