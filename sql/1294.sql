-- https://leetcode.com/problems/weather-type-in-each-country/


with a as (
    select country_id, avg(weather_state) as avg_weather
    from Weather
    where month(day) = 11
    group by country_id
)

select
    b.country_name,
    case
    when avg_weather <= 15 then 'Cold'
    when avg_weather >= 25 then 'Hot'
    else 'Warm'
    end as weather_type
from a inner join Countries b on a.country_id = b.country_id