-- https://leetcode.com/problems/number-of-accounts-that-did-not-stream/description/

with active as (
    select account_id
    from subscriptions
    where
        1=1
        and extract(year from start_date) <= 2021
        and extract(year from end_date) >= 2021
),
streamed as (
    select distinct account_id
    from streams
    where extract(year from stream_date) = 2021
)

select count(1) as accounts_count from active where account_id not in(select * from streamed);