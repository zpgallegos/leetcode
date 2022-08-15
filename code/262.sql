

with banned as (
    select users_id as id
    from Users
    where banned = 'Yes'
)

select
    a.request_at as Day,

    round(
        sum(
            case
            when a.status like 'cancelled%' then
                case
                when client_id in (select id from banned) or driver_id in (select id from banned) then 0
                else 1
                end
            else 0
            end
        ) /
        sum(
            case
            when client_id in (select id from banned) or driver_id in (select id from banned) then 0
            else 1
            end
        ), 2) as "Cancellation Rate"


from Trips a

where a.request_at between '2013-01-01' and '2013-10-03'

group by a.request_at

having sum(
    case when client_id not in(select id from banned)
    and driver_id not in (select id from banned) then 1 else 0 end) > 0
    