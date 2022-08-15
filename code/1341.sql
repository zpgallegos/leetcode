-- https://leetcode.com/problems/movie-rating/


with movies as (
    select
        a.*,
        b.name,
        c.title,
        rank() over(order by b.name) as name_rank,
        rank() over(order by c.title) as title_rank,
        count(1) over(partition by a.user_id) as rating_count,
        coalesce(s.avg_rating, 0) as avg_rating

    from MovieRating a
        inner join Users b on a.user_id = b.user_id
        inner join Movies c on a.movie_id = c.movie_id
        left join (
            select movie_id, avg(rating) as avg_rating
            from MovieRating
            where year(created_at) = 2020 and month(created_at) = 2
            group by movie_id
        ) s on a.movie_id = s.movie_id
)

(select a.name as results
from movies a
order by a.rating_count desc, a.name_rank
limit 1)

union (

select a.title as results
from movies a
order by a.avg_rating desc, a.title_rank
limit 1
)

--

(
    select s.name as results from (
        select a.user_id, b.name
        from MovieRating a inner join Users b on a.user_id = b.user_id
        group by a.user_id, b.name
        order by count(1) desc, b.name
    ) s limit 1
) union (
    select s.title as results from (
        select a.movie_id, b.title
        from MovieRating a inner join Movies b on a.movie_id = b.movie_id
        where year(a.created_at) = 2020 and month(a.created_at) = 2
        group by a.movie_id, b.title
        order by avg(a.rating) desc, b.title
    ) s limit 1
)



