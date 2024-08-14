-- https://leetcode.com/problems/tournament-winners/

with cte as (
    select
        b.group_id,
        a.*
    from (
        select first_player as player_id, first_score as score from matches union all
        select second_player as player_id, second_score as score from matches
    ) a inner join players b on a.player_id = b.player_id
),
grpd as (
    select
        a.group_id,
        a.player_id,
        sum(score) as player_total
    from cte a
    group by 1, 2
),
rnkd as (
    select
        a.*,
        row_number() over(partition by a.group_id order by a.player_total desc, a.player_id) as rnk
    from grpd a
)

select group_id, player_id from rnkd where rnk = 1;