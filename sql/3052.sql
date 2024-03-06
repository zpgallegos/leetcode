-- https://leetcode.com/problems/maximize-items/description/

with cte as (
    select 
        item_type, 
        count(1) as item_n,
        sum(square_footage) as space
    from inventory
    group by item_type
), types as (
    select 'prime_eligible' as item_type, 0 as item_n, 0 as space union
    select 'not_prime' as item_type, 0 as item_n, 0 as space
), sizes as (
    select * from cte union
    select * from types where item_type not in(select item_type from cte)
), prime as (
    select
        item_type,
        floor(500000 / space) * item_n as item_count,
        floor(500000 / space) * space as used_space
    from sizes
    where item_type = 'prime_eligible'
), not_prime as (
    select 
        item_type, 
        floor((500000 - (select max(used_space) from prime)) / space) * item_n as item_count
    from sizes
    where item_type = 'not_prime'
)

select * from (
    select item_type, item_count from prime union
    select item_type, item_count from not_prime
) sub order by item_count desc;