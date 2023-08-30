select
    stock_name,
    sum(price - last_price) as capital_gain_loss
from
    (
        select
            stock_name,
            operation,
            price,
            lag(price, 1) over(
                partition by stock_name
                order by
                    operation_day
            ) as last_price
        from
            Stocks
    ) sub
where operation = "Sell"
group by stock_name