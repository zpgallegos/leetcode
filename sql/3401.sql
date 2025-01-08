-- https://leetcode.com/problems/find-circular-gift-exchange-chains/description/

with 

recursive cte as (

    select
        a.*,
        a.giver_id as giver_start
    from secretsanta a

    union

    select
        b.*,
        a.giver_start
    from cte a
        inner join secretsanta b on a.receiver_id = b.giver_id and b.giver_id != a.giver_start

),

aggd as (

    select
        giver_start,
        count(1) as chain_length,
        sum(gift_value) as total_gift_value
    from cte
    group by 1

),

uniq as (

    select distinct chain_length, total_gift_value
    from aggd

)

select
    row_number() over win as chain_id,
    a.*
from uniq a
window win as (order by a.chain_length desc, a.total_gift_value desc)
order by 2 desc, 3 desc