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


-- https://leetcode.com/problems/finding-the-topic-of-each-post/

with kw as (
    select a.topic_id, lower(a.word) as word
    from keywords a
),
psts as (
    select a.post_id, lower(a.content) as content
    from posts a
),
matches as (
    select
        a.post_id,
        group_concat(a.topic_id order by a.topic_id separator ',') as topic
    from (
        select distinct
            a.post_id,
            b.topic_id
        from psts a cross join kw b
        where concat(' ', a.content, ' ') like concat('% ', b.word, ' %')
    ) a
    group by 1
)

select * from matches union
select a.post_id, "Ambiguous!" as topic from psts a where a.post_id not in(select post_id from matches);
