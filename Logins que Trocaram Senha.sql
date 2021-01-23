-- Mostra Logins que trocaram a senha nos ultimos dias
SELECT name, LOGINPROPERTY(name, 'PasswordLastSetTime') AS 'SenhaTrocada' 
FROM sys.sql_logins
WHERE LOGINPROPERTY(name, 'PasswordLastSetTime') < DATEADD(dd, -60, GETDATE());