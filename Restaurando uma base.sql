-- declarando as vari�veis para colocar caminho, extens�o, data, hora e uma pra concatenar tudo
DECLARE @PATH VARCHAR(60)
DECLARE @FILEEXTENSION VARCHAR(4)
DECLARE @DATE VARCHAR(8)
DECLARE @TIME VARCHAR(4)
DECLARE @FULLPATH VARCHAR(80)

 

-- definindo o valor das vari�veis
SET @PATH = 'E:\BKP TLOG_13_04\Backup_Tlogs\CPC_backup_'
SET @DATE = '20120420'
SET @TIME = '1400'
SET @FILEEXTENSION = '.trn'

 

-- esse ROTINA_RESTORE � pra usar GOTO igual em arquivos batch
ROTINA_RESTORE:

 

-- se a vari�vel TIME tiver apenas 3 caracteres, concatene tudo e adicione um zero pra hora
IF (SELECT LEN(@TIME))=3
SET @FULLPATH = @PATH+@DATE+'0'+@TIME+@FILEEXTENSION

 

-- sen�o, concatene tudo sem adicionar o zero
ELSE
SET @FULLPATH = @PATH+@DATE+@TIME+@FILEEXTENSION

 

-- um print s� pra eu saber em que arquivo est� no momento
PRINT 'Iniciando o restore de ---> '+@FULLPATH
RESTORE LOG CPC
FROM DISK = @FULLPATH
WITH NORECOVERY;
PRINT @FULLPATH+' '+' ---> restaurado com sucesso!'


--  ajusta para o pr�ximo arquivo
SET @TIME = @TIME + 15 



-- se chegar em 24:00 devemos aumentar o dia certo?
IF @TIME = 2400
BEGIN
SET @TIME = '0000'
SET @DATE = @DATE + 1
GOTO ROTINA_RESTORE;
END 


--sen�o chegar em 24:00, � s� voltar para ROTINA_RESTORE
ELSE
GOTO ROTINA_RESTORE;