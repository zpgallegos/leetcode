-- https://leetcode.com/problems/friday-purchases-i/description/

select * from (
    select
        week_of_month,
        purchase_date,
        sum(amount_spend) as total_amount
    from (
        select
            *,
            datepart(weekday, purchase_date) as wkday,
            ceiling(datepart(day, purchase_date) / 7.0) as week_of_month
        from purchases
        ) sub
    where wkday = 6
    group by week_of_month, purchase_date
) sub order by week_of_month;
