-- https://leetcode.com/problems/the-category-of-each-member-in-the-store/description/


with cte as (
    select
        sub.*,
        (100 * sub.purchases) / sub.visits as conv
    from (
        select
            a.member_id,
            a.name,
            count(distinct b.visit_id) as visits,
            count(c.visit_id) as purchases
        from members a
            left join visits b on a.member_id = b.member_id
            left join purchases c on b.visit_id = c.visit_id
        group by 1, 2
    ) sub
)

select
    a.member_id,
    a.name,
    case
    when a.visits = 0 then 'Bronze'
    when a.conv >= 80 then 'Diamond'
    when a.conv >= 50 then 'Gold'
    else 'Silver'
    end as category
from cte a;