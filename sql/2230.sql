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