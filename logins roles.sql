---Script – User Role List and Login Type:


SELECT

          CASE

           WHEN SSPs2.name IS NULL THEN 'Public'

           ELSE SSPs2.name

          END AS 'Role Name',

          SSPs.name AS 'Login Name',

          Case SSPs.is_disabled

           When 0 Then '0 – Habilitado'

           When 1 Then '1 – Desabilitado'

          End AS 'Login Status',

          SSPs.type_desc AS 'Login Type'

FROM sys.server_principals SSPs LEFT JOIN sys.server_role_members SSRM

                                                       ON SSPs.principal_id  = SSRM.member_principal_id

                                                      LEFT JOIN sys.server_principals SSPs2

                                                       ON SSRM.role_principal_id = SSPs2.principal_id

WHERE SSPs2.name IS NOT NULL

OR SSPs.type_desc <> 'CERTIFICATE_MAPPED_LOGIN'

AND SSPs.type_desc <> 'SERVER_ROLE'

AND SSPs2.name IS NULL

ORDER BY SSPs2.name DESC, SSPs.name


--------------------------------------------------------------------------------------------------------------------------------------------------------

--Script – Database Login and User Role List:

With Roles (Role, Login, [User])

As

(SELECT SDPs2.name AS Role,

               SDPs1.name AS  [User],

               SL.name AS Login

FROM [Master].sys.database_principals SDPs1

                                              Inner JOIN [Master].sys.syslogins SL

                                                  ON SDPs1.sid = SL.sid  

                                              Inner JOIN [Master].sys.database_role_members SRM

                                                  ON SRM.member_principal_id = SDPs1.principal_id

                                                Inner JOIN [Master].sys.database_principals SDPs2

                                                  ON SRM.role_principal_id = SDPs2.principal_id

                                                  AND SDPs2.type IN ('R')
                                                  

WHERE SDPs1.type IN ('S','U','G'))

Select * from Roles

ORDER BY Role, Login

---------------------------------------------------------------------------------------------------------------------------------------------------------

--Script – User Role Permissions – Grantor, Object Permissions and Permissions Type.


SELECT SDPs1.name AS [User],

            SDBPs.permission_name AS [Permissions],

             ISNULL(SDBPs.class_desc,'') COLLATE latin1_general_cs_as +     

 ISNULL(':'+SO.name,'') COLLATE latin1_general_cs_as   +  ISNULL(':'+SC.name,'') COLLATE latin1_general_cs_as As PermissionObjetct,

            SDPs.name as Grantor,

            SDBPs.state_desc AS PermissionType

FROM [Master].sys.database_permissions SDBPs

                                                INNER JOIN  [Master].sys.database_principals  SDPs

                                                on SDBPs.grantor_principal_id=SDPs.principal_id

 INNER JOIN  [Master].sys.database_principals SDPs1

  on SDBPs.grantee_principal_id=SDPs1.principal_id

                                              LEFT OUTER JOIN [Master].sys.sysobjects SO

                                               on SDBPs.major_id=SO.id and SDBPs.class =1

                                              LEFT OUTER JOIN [Master].sys.schemas  SC

                                               on SDBPs.major_id=SC.[schema_id]

WHERE SDPs1.name IN ('public')

And SDBPs.permission_name NOT IN('CONNECT')

ORDER BY User, Permissions, PermissionObjetct