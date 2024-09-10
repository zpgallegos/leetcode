-- https://leetcode.com/problems/maximize-items/


with types as (
    select
        a.item_type,
        count(1) as n_items,
        sum(a.square_footage) as total_footage
    from inventory a
    group by 1
),
prime1 as (
    select 
        a.*,
        floor(500000 / a.total_footage) as n_combs
    from types a
    where a.item_type = 'prime_eligible'
),
prime as (
    select
        a.item_type,
        a.n_combs * a.total_footage as total_footage,
        a.n_combs * a.n_items as item_count
    from prime1 a
),
not_prime as (
    select 
        a.item_type,
        floor((500000 - (select total_footage from prime)) / a.total_footage) * a.n_items
    from types a
    where a.item_type = 'not_prime'
)

select * from (
    select item_type, item_count from prime union
    select * from not_prime
) s order by 2 desc;