-- Então como monitorar a quantidade de alterações de uma tabela pra saber se ela está chegando aos malvados 20% + 500 ?

/*SQL 2005*/
SELECT SO.NAME AS tableName, SC.NAME AS columnName, SSC.*, SSR.* FROM sys.sysrowsetcolumns SSC
INNER JOIN sys.sysrowsets SSR ON SSC.rowsetID = SSR.rowsetID
INNER JOIN sys.sysobjects SO ON SSR.idmajor = SO.id
INNER JOIN sys.syscolumns SC on SSR.idmajor = SC.id AND SSC.rowsetcolid = SC.colid
WHERE SO.xtype = 'U'
ORDER BY so.name, sc.colid

/*SQL 2008*/
SELECT SO.NAME AS tableName, SC.NAME AS columnName, SSC.*, SSR.* FROM sys.sysrscols SSC
INNER JOIN sys.sysrowsets SSR ON SSC.rowsetID = SSR.rowsetID
INNER JOIN sys.sysobjects SO ON SSR.idmajor = SO.id
INNER JOIN sys.syscolumns SC on SSR.idmajor = SC.id AND SSC.rscolid = SC.colid
WHERE SO.xtype = 'U'
ORDER BY so.name, sc.colid

-- Precisa habilitar o DAC, as tabelas sysrscols, sysrowsetcolumns e sysrowsets só podem ser acessadas pelo DAC.
-- Links para habilitar o DAC
   -- http://msdn.microsoft.com/en-us/library/ms178068.aspx
   -- http://translate.google.com.br/translate?hl=pt-BR&sl=en&u=http://msdn.microsoft.com/en-us/library/ms178068(v%3Dsql.105).aspx&prev=/search%3Fq%3Ddac%2Bsql%2Bserver%26hl%3Dpt-BR%26tbo%3Dd%26biw%3D1280%26bih%3D939&sa=X&ei=lAT_UN-zFY2o8ATciYAY&sqi=2&ved=0CDAQ7gEwAA