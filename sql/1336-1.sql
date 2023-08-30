-- https://leetcode.com/problems/number-of-transactions-per-visit/

with recursive cnts as (

    select
        v.user_id,
        v.visit_date,
        count(1) as transactions_count

    from visits v
        inner join transactions t on v.user_id = t.user_id and v.visit_date = t.transaction_date
    
    group by v.user_id, v.visit_date

), counts as (
    
    select * from cnts

    union

    select v.user_id, v.visit_date, 0 as transactions_count
    from visits v
        left join cnts c on v.user_id = c.user_id and v.visit_date = c.visit_date
    where c.user_id is null

), trans as (
    
    select transactions_count, count(1) as visits_count
    from counts
    group by transactions_count

), cte as (
    
    select * from (
        select * from trans where transactions_count = 0
        union
        select 0 as transactions_count, 0 as visits_count
        from trans
        where 0 not in(select transactions_count from trans)
    ) q


    union

    select 
        cte.transactions_count + 1 as transactions_count, 
        coalesce(trans.visits_count, 0) as visits_count
    from cte
        left join trans on cte.transactions_count + 1 = trans.transactions_count
    
    where cte.transactions_count + 1 <= (select max(transactions_count) from trans)

)

select * from cte;