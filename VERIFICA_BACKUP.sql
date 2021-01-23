DECLARE @VERSAO VARCHAR(100)

SET @VERSAO = (SELECT @@VERSION)

PRINT @VERSAO 

 SELECT SUBSTRING((SELECT @@VERSION),1,25)
 PRINT @VERSAO 

 IF @VERSAO = 'Microsoft SQL Server 2000'
 BEGIN 
		select  *
		      from  
			 (select     bacs.database_name as banco,
			             max(bacs.backup_finish_date) as dt_backup
			  from       msdb.dbo.backupmediafamily as bacm
			  inner join msdb.dbo.backupset as bacs
			  on         bacm.media_set_id = bacs.media_set_id 
			  inner join master.dbo.sysdatabases as d
			  on         d.dbid = db_id(bacs.database_name)
		   	  where      bacs.[type] = 'D'
		   	  and   convert(varchar(30),databasepropertyex(d.name,'Status')) = 'ONLINE' 
                          and   databasepropertyex(d.name,'IsInStandBy') = 0 
                          and   convert(varchar(30),databasepropertyex(d.name,'Updateability')) = 'READ_WRITE'
		   	  and   d.name not in('tempdb','model')
			  group by   bacs.database_name) consulta
		      where dt_backup < (select getdate() -1)
END
ELSE
	
select  *
		      from  
			 (select     bacs.database_name as banco,
			             max(bacs.backup_finish_date) as dt_backup
			  from       msdb.dbo.backupmediafamily as bacm
			  inner join msdb.dbo.backupset as bacs
			  on         bacm.media_set_id = bacs.media_set_id 
			  inner join master.sys.databases as d
			  on         d.database_id = db_id(bacs.database_name)
		   	  where      bacs.[type] = 'D'
		   	  and   d.state_desc = 'ONLINE'
		   	  and   d.name not in('tempdb','model','Northwind','pubs')
              and   d.is_read_only<>1
              and   d.is_in_standby<>1
			  group by   bacs.database_name) consulta
		      where dt_backup < (select getdate() -1)
END



 
 
 @VERSAO = 'Microsoft SQL Server 2012 (SP1)'