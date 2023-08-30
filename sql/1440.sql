

select
    a.left_operand,
    a.operator,
    a.right_operand,
    case a.operator
    when '<' then if(b.value < c.value, 'true', 'false')
    when '=' then if(b.value = c.value, 'true', 'false')
    when '>' then if(b.value > c.value, 'true', 'false')
    else null
    end as "value"

from Expressions a 
    inner join Variables b on a.left_operand = b.name
    inner join Variables c on a.right_operand = c.name