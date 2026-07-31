-- https://leetcode.com/problems/find-emotionally-consistent-users/description/

with reaction_counts as (
    select
        user_id,
        reaction,
        count(1) as reaction_count,
        sum(count(1)) over(partition by user_id) as total_reactions
    from reactions
    group by 1, 2
)

select
    user_id,
    reaction as dominant_reaction,
    round(reaction_count::numeric / total_reactions, 2) as reaction_ratio
from reaction_counts
where
    total_reactions >= 5
    and reaction_count * 5 >= total_reactions * 3
order by 3 desc, 1;
