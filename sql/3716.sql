-- https://leetcode.com/problems/find-churn-risk-customers/description/


with history as (
    select
        *,
        row_number() over event_win as rn,
        max(monthly_amount) over user_win as max_historical_amount,
        max(event_date) over user_win - min(event_date) over user_win as days_as_subscriber,
        count(1) filter(where event_type = 'downgrade') over user_win as downgrade_count
    from subscription_events
    window
        event_win as (partition by user_id order by event_date desc, event_id desc),
        user_win as (partition by user_id)
)

select
    user_id,
    plan_name as current_plan,
    monthly_amount as current_monthly_amount,
    max_historical_amount,
    days_as_subscriber
from history
where
    rn = 1
    and event_type != 'cancel'
    and days_as_subscriber >= 60
    and monthly_amount / max_historical_amount < 0.50
    and downgrade_count > 0
order by 5 desc, 1;




