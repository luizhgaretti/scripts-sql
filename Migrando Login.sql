/*
O script abaixo gera o script de criação de Logins.. 
Caso seja necessário migra-lo de uma maquina para outra....
Obs: Alem de criar .. é preciso saber o nivel de permissão.. para replicar tbm
*/

SELECT 
  'create login [' + p.name + '] ' + 
  case when p.type in('U','G') then 'from windows ' else '' end +
  'with ' +
  case when p.type = 'S' then 'password = ' + master.sys.fn_varbintohexstr(l.password_hash) + ' hashed, ' +
  'sid = ' + master.sys.fn_varbintohexstr(l.sid) + 
  ', check_expiration = ' + case when l.is_expiration_checked > 0 then 'ON, ' else 'OFF, ' end + 
  'check_policy = ' + case when l.is_policy_checked > 0 then 'ON, ' else 'OFF, ' end +
  case when l.credential_id > 0 then 'credential = ' + c.name + ', ' else '' end 
  else '' end +
  'default_database = ' + p.default_database_name +
  case when len(p.default_language_name) > 0 then ', default_language = ' + p.default_language_name else '' end
FROM sys.server_principals p 
LEFT JOIN sys.sql_logins l ON p.principal_id = l.principal_id 
LEFT JOIN sys.credentials c ON  l.credential_id = c.credential_id
WHERE p.type in('S','U','G')
AND p.name <> 'sa'