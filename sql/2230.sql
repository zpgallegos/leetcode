-- https://leetcode.com/problems/the-users-that-are-eligible-for-discount/

create or replace function getUserIds(startDate date, endDate date, minAmount int)
returns table(user_id int) as $$
begin
    return query (
        select distinct a.user_id
        from purchases a
        where
            1=1
            and a.amount >= minAmount
            and a.time_stamp between startDate and endDate
        order by 1
    );
end;
$$ language plpgsql;


-- https://leetcode.com/problems/the-users-that-are-eligible-for-discount/description/

create procedure getUserIDs(@startDate date, @endDate date, @minAmount int) as
begin
    select distinct user_id
    from purchases
    where
        time_stamp between @startDate and @endDate and
        amount >= @minAmount
    order by user_id
end