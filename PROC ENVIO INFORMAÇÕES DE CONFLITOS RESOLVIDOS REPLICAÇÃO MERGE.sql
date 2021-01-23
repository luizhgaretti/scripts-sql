ALTER PROCEDURE [dbo].[PR_MONITOR_REP_CONFLITOS]  

AS  

if (SELECT COUNT(*) FROM MONITORDBA..MONITOR_REP_CONFLITOS) > 0  

begin  

 declare @TableHTML varchar(max)  

  SET @TableHTML =      

 '<font face="Verdana" size="4">Replicação Tiffany com Conflitos</font>    

 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="16%" id="AutoNumber1" height="50">    

  <tr>    

 <td width="50%" height="22" bgcolor="#000080"><b>    

 <font face="Verdana" size="2" color="#FFFFFF">Tabela</font></b></td>    
 
 <!-- COMENTARIO  

 <td width="50%" height="22" bgcolor="#000080"><b>    

 <font face="Verdana" size="2" color="#FFFFFF">Tabela com Conflito</font></b></td>    

 FECHA COMENTARIO--->  

 <td width="100%" height="22" bgcolor="#000080"><b>    

 <font face="Verdana" size="2" color="#FFFFFF">Informação do Conflito</font></b></td>    

 <td width="50%" height="22" bgcolor="#000080"><b>    

 <font face="Verdana" size="2" color="#FFFFFF">Data do Conflito</font></b></td>  

  </tr>    

   <tr>    

    '  

 select   

 @TableHTML = @TableHTML +   

 '<tr><td><font face="Verdana" size="1">' + ISNULL(convert(varchar,C.TABELA), '') +'</font></td>' +      

 --'<td><font face="Verdana" size="1">' + ISNULL(convert(varchar,C.TABELA_CONFLITO),'') + '</font></td>' +     

 '<td><font face="Verdana" size="1">' + ISNULL(convert(varchar,C.INFORMACAO_CONFLITO), '') + '</font></td>' +  

 '<td><font face="Verdana" size="1">' + ISNULL(convert(varchar,C.DATA_CONFLITO) ,'') + '</font></td>' +  
 
 +' </tr>'  

 FROM MONITORDBA..MONITOR_REP_CONFLITOS C  

  WHERE C.INFORMACAO_CONFLITO LIKE '%UPDATE%'

  OR C.INFORMACAO_CONFLITO LIKE '%DELETE%'

 SELECT @TableHTML =  @TableHTML + '</table>'  

 EXEC msdb.dbo.sp_send_dbmail    

 @profile_name = 'captasql2',      

 @recipients='sql.server@capta.com.br; antonio.caldeira@capta.com.br; nelson.hamilton@capta.com.br',      

 --@recipients='nelson.hamilton@capta.com.br',      

 @subject = 'Replicação Tiffany com Conflitos - RESOLVIDOS',      

 @body = @TableHTML,      

 @body_format = 'HTML' ;   

 end  







  






