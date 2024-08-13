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
