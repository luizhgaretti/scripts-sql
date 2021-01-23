-- declarando as variáveis para colocar caminho, extensão, data, hora e uma pra concatenar tudo
DECLARE @PATH VARCHAR(60)
DECLARE @FILEEXTENSION VARCHAR(4)
DECLARE @DATE VARCHAR(8)
DECLARE @TIME VARCHAR(4)
DECLARE @FULLPATH VARCHAR(80)

 

-- definindo o valor das variáveis
SET @PATH = 'E:\BKP TLOG_13_04\Backup_Tlogs\CPC_backup_'
SET @DATE = '20120420'
SET @TIME = '1400'
SET @FILEEXTENSION = '.trn'

 

-- esse ROTINA_RESTORE é pra usar GOTO igual em arquivos batch
ROTINA_RESTORE:

 

-- se a variável TIME tiver apenas 3 caracteres, concatene tudo e adicione um zero pra hora
IF (SELECT LEN(@TIME))=3
SET @FULLPATH = @PATH+@DATE+'0'+@TIME+@FILEEXTENSION

 

-- senão, concatene tudo sem adicionar o zero
ELSE
SET @FULLPATH = @PATH+@DATE+@TIME+@FILEEXTENSION

 

-- um print só pra eu saber em que arquivo está no momento
PRINT 'Iniciando o restore de ---> '+@FULLPATH
RESTORE LOG CPC
FROM DISK = @FULLPATH
WITH NORECOVERY;
PRINT @FULLPATH+' '+' ---> restaurado com sucesso!'


--  ajusta para o próximo arquivo
SET @TIME = @TIME + 15 



-- se chegar em 24:00 devemos aumentar o dia certo?
IF @TIME = 2400
BEGIN
SET @TIME = '0000'
SET @DATE = @DATE + 1
GOTO ROTINA_RESTORE;
END 


--senão chegar em 24:00, é só voltar para ROTINA_RESTORE
ELSE
GOTO ROTINA_RESTORE;