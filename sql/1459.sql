-- https://leetcode.com/problems/rectangles-area/


with crs as (
    select
        a.id as p1,
        b.id as p2,
        a.x_value as x1,
        b.x_value as x2,
        a.y_value as y1,
        b.y_value as y2
    from Points a cross join Points b
    where a.id < b.id
), area as (
    select
        crs.p1,
        crs.p2,
        abs(crs.x1 - crs.x2) * abs(crs.y1 - crs.y2) as area

    from crs
)

select * from area a where a.area > 0 order by area desc, p1, p2;

