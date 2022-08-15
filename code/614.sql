-- https://leetcode.com/problems/second-degree-follower/


select * from (
    select followee as follower, count(follower) as num
    from Follow
    where followee in(
        select follower
        from Follow
        group by follower
        having count(followee) > 0)
    group by followee
    having count(follower) > 0
) s order by follower;


select * from (
    select a.followee as follower, count(a.follower) as num
    from Follow a
        inner join (
            select follower
            from Follow
            group by follower
            having count(followee) > 0
        ) q on a.followee = q.follower
    group by a.followee
    having count(a.follower) > 0
) s order by follower;