USE [master]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_VPN]    Script Date: 12/17/2012 16:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_VERIFICA_VPN]
AS
BEGIN

-- Declara a variavel
DECLARE  @PING_VPN TABLE
(
ID_IPVPN INT IDENTITY(1,1),
RESULTADO VARCHAR (100)
)
 DECLARE @MSG_ERRO_2 VARCHAR(200)
 DECLARE @MSG_ERRO VARCHAR(200)
 DECLARE @error_message VARCHAR (255)
 DECLARE @to VARCHAR (200)
 DECLARE @from VARCHAR (200)
 DECLARE @assunto varchar (1000)

-- Coloco os emails em uma variavel, e defino o assunto do email
  set @error_message = 'Falha na conexão com a VPN PROD --> FRACTO'
  set @to = 'andre.nakazima@localcred.com.br'
  set @from = 'dba@localcred.com.br'
  
-- Monta o comando para ser executado no cmd
INSERT INTO @PING_VPN (RESULTADO) EXEC xp_cmdshell 'PING SRV-BD-PROD-ESP'
SELECT @msg_erro = RESULTADO FROM @PING_VPN WHERE ID_IPVPN = 9
SELECT @MSG_ERRO_2 = RESULTADO FROM @PING_VPN WHERE ID_IPVPN = 3 


--Faz o select se o resultado não existir então manda o email.
IF  EXISTS (SELECT  * FROM @PING_VPN WHERE /*RESULTADO LIKE '%Packets%' 										
    AND*/ 
       SUBSTRING(RESULTADO,4,43) IN (' Packets: Sent = 4, Received = 4, Lost = 0 ')
    OR SUBSTRING(RESULTADO,4,43) IN (' Packets: Sent = 4, Received = 3, Lost = 1 ')
    OR SUBSTRING(RESULTADO,4,43) IN (' Packets: Sent = 4, Received = 2, Lost = 2 ')
    OR SUBSTRING(RESULTADO,4,43) IN (' Packets: Sent = 4, Received = 1, Lost = 3 ')
     )
   SELECT  'ok' 
   
   
   
   ELSE BEGIN
   SELECT @assunto = 'Falha na conexão com a VPN'
			   set @error_message = 'Falha na conexão com a VPN PROD --> FRACTO'
			    + @MSG_ERRO + @MSG_ERRO_2
    exec master.dbo.sp_SQLNotify
                @to,
                @from,
                @assunto,
                @error_message 
   
  END 
END
begin
IF not EXISTS (SELECT  * FROM @PING_VPN WHERE RESULTADO LIKE '%HOST UNREACHABLE%')
	select 'ok'  

ELSE 
begin
SELECT @assunto = 'Falha na conexão com a VPN'
   set @error_message = 'Falha na conexão com a VPN PROD --> FRACTO'
			    + @MSG_ERRO + @MSG_ERRO_2
    exec master.dbo.sp_SQLNotify
                @to,
                @from,
                @assunto,
                @error_message 


end
end