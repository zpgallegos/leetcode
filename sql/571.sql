-- https://leetcode.com/problems/find-median-given-frequency-of-numbers/

with cfg as (
    select
        if(mod(sum(frequency), 2) = 0, 1, 0) as is_even,
        round(sum(frequency) / 2) as mid
    from Numbers
), cte as (
    select
        *,
        sum(frequency) over(order by num rows unbounded preceding) as cum,
        row_number() over(order by num) as rw,
        (select is_even from cfg) as is_even,
        (select mid from cfg) as mid
    from Numbers
)

select * from cte

select avg(num) as median
from cte
where
    case
    when (select is_even from cfg) then -- average mid/mid+1
        case
        when (select mid from cfg) in (select cum from cte) then -- edge case
            rw in(
                select rw from cte where cum = (select mid from cfg) union
                select rw + 1 from cte where cum = (select mid from cfg)
            )
        else
            frequency = (select max(frequency) from cte where cum <= (select mid + 1 from cfg))
        end
    else
        num = (select min(num) from cte where cum >= (select mid from cfg))
    end



