select
    sub.name,
    sub.travelled_distance
    
from
    (
        select
            a.id,
            a.name,
            sum(coalesce(b.distance, 0)) as travelled_distance
        from
            Users a
            left join Rides b on a.id = b.user_id
        group by
            a.id
    ) sub
order by
    sub.travelled_distance desc,
    sub.name;