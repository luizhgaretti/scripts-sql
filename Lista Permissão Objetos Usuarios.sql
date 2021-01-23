SELECT
prmssn.permission_name AS [Permission],
sp.type_desc,
sp.name,
grantor_principal.name AS [Grantor],
grantee_principal.name AS [Grantee]
FROM
sys.all_objects AS sp
INNER JOIN sys.database_permissions AS prmssn ON prmssn.major_id=sp.object_id AND prmssn.minor_id=0 AND prmssn.class=1
INNER JOIN sys.database_principals AS grantor_principal ON grantor_principal.principal_id = prmssn.grantor_principal_id
INNER JOIN sys.database_principals AS grantee_principal ON grantee_principal.principal_id = prmssn.grantee_principal_id
WHERE
(SCHEMA_NAME(sp.schema_id)='dbo')
ORDER BY sp.type
go

-- Este script faz basicamente a mesma coisa que o de cima
sp_helprotect