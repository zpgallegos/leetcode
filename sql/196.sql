-- https://leetcode.com/problems/delete-duplicate-emails/description/

delete from Person where id not in (
    select sub.id from (
        select min(id) as id
        from Person
        group by email
    ) sub
)