--Criar job e agendar para executar todo dia x.. assim criamos uma baseline 

-- CONTROLE MENSAL DOS TAMANHOS DAS TABELAS
use iss_osasco
go

DECLARE @HTML_Body VARCHAR(MAX)
DECLARE @HTML_Head VARCHAR(MAX)
DECLARE @HTML_Tail VARCHAR(MAX)


 SET @HTML_Head = '<html>'
 SET @HTML_Head = @HTML_Head + '<head>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <style>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' body{font-family: arial; font-size: 13px;}table{font-family: arial; font-size: 13px; border-collapse: collapse;width:100%} td {padding: 2px;height:15px;border:solid 1px black;} th {padding: 2px;background-color:black;color:white;border:solid 1px black;}' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' </style>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + '</head>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + '<body><b>Abaixo lista dos tamanhos das tabelas do database Iss_Osasco.</b><hr />' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + '<table>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <tr>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <th>Table Name</th>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <th>Numero de Linhas</th>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <th>Reserved KB</th>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <th>Data KB</th>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <th>Index_Size KB</th>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' <th>Unsed KB</th>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Head = @HTML_Head + ' </tr>' + CHAR(13) + CHAR(10) ;
 SET @HTML_Tail = '</table></body></html>' ; 
 
 
  create table #temp ([name] varchar(1000), [rows] varchar(1000), [reserved] varchar(1000),   
 [data] varchar(1000),   
 [index_size] varchar(1000), [unsed] varchar(1000))  
   
 insert into #temp  
   
 EXEC sp_MSforeachTable @command1="sp_spaceused '?' "  
   
 
 SET @HTML_Body = @HTML_Head + (select convert(varchar(50),LTRIM(RTRIM(name))) as [TD],convert(int,rows) as [TD],convert(bigint,LTRIM(RTRIM(replace(reserved,'KB','')))) as [TD],convert(bigint,LTRIM(RTRIM(replace(data,'KB','')))) as [TD],convert(bigint,LTRIM(RTRIM
 
 (replace(index_size,'KB','')))) as [TD],convert(bigint,LTRIM(RTRIM(replace(unsed,'KB','')))) as [TD]  from #temp  
 order by 3 desc  FOR XML RAW('tr') ,ELEMENTS) + @HTML_Tail

drop table #temp

EXEC MSDB..SP_SEND_DBMAIL
	@profile_name = 'SQLMAIL(LAMINA09)',
	@RECIPIENTS = 'danielgz@rgm.com.br;reinaldo@rgm.com.br;gregoryps@rgm.com.br;william@rgm.com.br;dba@rgm.com.br',
   	@body = @HTML_Body,
   	@body_format = 'HTML',
   	@SUBJECT = 'CONTROLE MENSAL DOS TAMANHOS DAS TABELAS'
	