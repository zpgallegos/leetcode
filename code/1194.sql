-- https://leetcode.com/problems/tournament-winners/

with scores as (
    select
        match_id,
        first_player as player,
        first_score as score
    from matches
    union
    select
        match_id,
        second_player as player,
        second_score as score
    from matches
), grp as (
    select
        b.group_id,
        a.player,
        sum(a.score) as total
    from scores a
        inner join players b on a.player = b.player_id
    group by
        b.group_id,
        a.player
), ranked as (
    select 
        *,
        row_number() over(partition by group_id order by total desc, player) as rnk
    from grp
)

select group_id, player as player_id
from ranked
where rnk = 1;