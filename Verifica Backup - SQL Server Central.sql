--Check Databse Backup file if it's Valid on multiple databses
--http://www.sqlservercentral.com/scripts/89763/


declare @recordTeble table (dataid int identity(1,1), dbname varchar(100),physicalDevice nvarchar(200))

declare @a int, @z int, @bakfile nvarchar(200), @sql nvarchar(max), @n varchar(2),  @bkname nvarchar(200)



insert into @recordTeble

select distinct b.name, bmf.physical_device_name from msdb.dbo.backupset b 

JOIN msdb.dbo.backupmediafamily bmf 

ON b.media_set_id = bmf.media_set_id

where b.backup_finish_date >= getdate()-1

and bmf.physical_device_name not like'%.trn' and bmf.physical_device_name not like'%Data Protector%'
and b.name is not null

select @a=1,@z=MAX(dataid) from @recordTeble



while @a< = @z

begin

select @bakfile = physicalDevice,@bkname = dbname from @recordTeble

where dataid=@a

print @bkname

restore verifyonly from disk = @bakfile

select @a=@a+1

end



