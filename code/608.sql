


select * from (
    select
        id, 
        'Root' as type
    from Tree
    where p_id is null

    union

    -- leaves

    select
        a.id,
        case when b.p_id is not null then 'Inner' else 'Leaf' end as type
    from Tree a left join Tree b on a.id = b.p_id
    where a.p_id is not null
) sub
order by sub.id;

