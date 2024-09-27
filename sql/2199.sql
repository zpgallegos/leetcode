-- https://leetcode.com/problems/finding-the-topic-of-each-post/

with cte as (
    select distinct
        a.post_id,
        b.topic_id
    from posts a cross join keywords b
    where a.content ~* ('\y' || b.word || '\y')
),
res as (
    select
        a.post_id,
        string_agg(a.topic_id::varchar, ',' order by a.topic_id) as topic
    from cte a
    group by 1
),
filled as (
    select * from res union
    select post_id, 'Ambiguous!' as topic from posts where post_id not in(select post_id from res)
)

select * from filled order by 1;