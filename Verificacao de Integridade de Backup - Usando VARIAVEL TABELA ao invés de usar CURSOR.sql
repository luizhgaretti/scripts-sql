/********************************************************************************************************************************************************/
/*********************************************VERIFICACAO DE INTEGRIDADE DE BACKUP (AGENDAR JOB NO CLIENTE)**********************************************/
/********************************************************************************************************************************************************/

/*
create table monitordba..Tb_MON_Integridade_Backup_Erro
(
cod int,
data varchar(20),
erro varchar(500)
)
*/

create table #backup_erro
(
cod int,
data varchar(20),
erro varchar(500)
)

declare @id int, 
@maxid int,
@BASE varchar(8000),
@CAMINHO VARCHAR(8000), 
@caminho2 as varchar(800),
@SSQL VARCHAR(8000)
set @caminho2 = 'D:\BACKUP\'
set @id = 0

declare @tab_var table
(id int,
nome varchar(30),
caminho VARCHAR(500))

--loop para pegar as bases
insert into @tab_var  (id, nome, caminho) 
select 
db.backup_set_id, db.database_name, dbf.physical_device_name 
from msdb..backupset db
join msdb..backupmediafamily dbf on dbf.media_set_id = db.media_set_id 
where dbf.physical_device_name like '' + @caminho2 + '%'
and backup_finish_date in 
						(select max(backup_finish_date) from msdb..backupset 
							--where convert(varchar,backup_finish_date, 112) <= convert(varchar,GETDATE(), 112)
								group by database_name )

select @MaxID = max(ID) , @ID = 0 from @tab_var
	
	while @ID < @MaxID

begin
select @ID = min(ID) from @tab_var where ID > @ID		
select @base = nome, @CAMINHO = caminho from @tab_var where ID = @ID

declare @cod int, @backupSetId as int
set @cod = 0

select @backupSetId = position from msdb..backupset where database_name = @base 
	    and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name= @base)
if @backupSetId is null 
begin 
insert into #backup_erro
select cod = @cod, GETDATE(), 'Verify failed. Backup information for database ' + @base + ' not found.'
end
BEGIN TRY
RESTORE VERIFYONLY FROM DISK =  @CAMINHO  WITH FILE = @backupSetId,  NOUNLOAD,  NOREWIND
END TRY
BEGIN CATCH
insert into #backup_erro
select cod = @cod, getdate(), 'VERIFY DATABASE ' + @base + ' is terminating abnormally.' 
END CATCH
end

insert into [200.158.216.85].monitordba.dbo.Tb_MON_Integridade_Backup_Erro
			select cod, (convert(varchar,data, 103)) as data, erro 
			from #backup_erro
				where data in (select max(data) from #backup_erro group by erro)

	drop table #backup_erro

/********************************************************************************************************************************************************/
/************************************************TRATAMENTO PARA MANDAR EMAIL (AGENDAR JOB NO 28.6)******************************************************/
/********************************************************************************************************************************************************/

use monitordba
go

select e.cod, c.sNome, e.data, e.erro 
into #Tb_MON_Integridade_Backup_Erro_Final
from Tb_MON_Integridade_Backup_Erro e
left join Tb_MON_Cad_Clientes c on c.ncodigo = e.cod and c.flgAtivo = 1
order by 3 desc
go

DECLARE @TableHTML  VARCHAR(MAX)

SELECT 
	@TableHTML =   
	'</table> 
	<br>
	<br>
	<tr>
	<tr>
	 <table id="AutoNumber1" style="BORDER-COLLAPSE: collapse" borderColor="#111111" height="40" cellSpacing="0" cellPadding="0" width="933" border="1">
	  <tr>
		<td width="35%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Codigo</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Cliente</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Data</font></b></td>
		<td width="30%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Erro</font></b></td>
	  </tr>'


select 
@TableHTML =  @TableHTML + 
	'<tr><td><font face="Verdana" size="1">' + isnull(convert(varchar,cod), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(snome, '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,data), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(erro, '') +'</font></td></tr>'   
from #Tb_MON_Integridade_Backup_Erro_Final

SELECT 
	@TableHTML =  @TableHTML + '</table>' +   
	'<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>'  

	
--print @TableHTML

if (select count(cod) from #Tb_MON_Integridade_Backup_Erro_Final) > 0

EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = 'captasql2',    
	@recipients='nelson.hamilton@capta.com.br',    
	@subject = 'Integridade de Backups - ALERTA!!!',    
	@body = @TableHTML,    
	@body_format = 'HTML' ;    

else

print 'Backups OK'


truncate table Tb_MON_Integridade_Backup_Erro

drop table #Tb_MON_Integridade_Backup_Erro_Final