
update Salary set sex = case when sex = 'f' then 'm' else 'f' end;

-- mysql
update Salary set sex = if(sex = 'f', 'm', 'f');