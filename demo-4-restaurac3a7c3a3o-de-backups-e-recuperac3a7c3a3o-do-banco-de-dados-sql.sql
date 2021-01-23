-- Conecta-se ao SQL Server no banco Master --
Use master
Go

-- Alterando o Status do Banco para Emergency e Limitando Acesso dos Usu�rios --
Alter Database FATEC
 SET Emergency, Single_User, Read_Only
Go 

-- Verificando o Status do banco --
Use FATEC
Go

SELECT DATABASEPROPERTYEX('FATEC', 'Status') As Status, 
             DATABASEPROPERTYEX('FATEC', 'Recovery') As 'Modelo de Recupera��o',
             DATABASEPROPERTYEX('FATEC', 'UserAccess') As 'Forma de Acesso', 
             DATABASEPROPERTYEX('FATEC', 'Version') As 'Vers�o' 
Go

-- Recuperando o Banco de Dados por Completo - Backup Database --
Use master
Go

Restore Database FATEC READ_WRITE_FILEGROUPS
 From Disk = 'C:\Users\Junior Galv�o\Desktop\Fatec\Backup-Database-FATEC.bak'
 With File=1, 
 Replace, 
 NoRecovery
Go 

--Restaurando do Log e liberando o Banco de Dados
Use master
Go

Restore Log FATEC
 From Disk = 'C:\Users\Junior Galv�o\Desktop\Fatec\Backup-Log-FATEC.bak'
 With Recovery
Go

-- Acessando o Banco de Dados - FATEC -- 
USE FATEC
Go

/* Iniciando o processo de Rompimento do Banco de Dados, simulando uma queda de Energia --
Abrindo uma nova Transa��o
*/

BEGIN Transaction Tran1
 UPDATE Clientes 
  SET Email = 'Maria.Silva@fatec.edu.br'
 WHERE ClientesID = 2
Go

/* Escrevendo/Gravando os dados armazenados em Buffer ou Dirty Pages(P�ginas Sujas). 
 Somente ap�s a verifica��o e cria��o do CheckPoint os dados ser�o armazenados no Disco*/
CHECKPOINT
Go

-- Abrir uma nova conex�o e execute o comando �SHUTDOWN WITH NOWAIT� --

/*
Ao executar este comando o SQL Server ir� interromper o funcionamento do servi�o Database Engine,
   mesmo que uma transa��o esteja em funcionamento e seu arquivo de dados fique aberto.
  
   Neste momento o Log de Transa��o esta incompleto, devido a falha na confirma��o da Transa��o.
   
   Este tipo de situa��o � facilmente contornando atrav�s da reinicializa��o do servi�o Database Engine,
   numa situa��o normal, ao ser inicializado, o SQL Server realizar� o rOLLBACK das transa��es que ficaram em aberto,
   fazendo uso das informa��es contidas no Arquivo de Log.
   */


/* Corrompendo o Transaction Log -- 
O processo de corromper o Transaction Log � simples, podemos utilizar o Notepad, 
 apagando ou alterando alguns caracteres no seu in�cio do arquivo e depois salvar. 
 Ap�s corromper o arquivo de log inicie o SQL Server e tente entrar no banco FATEC. 
 Ser� retornada a mensagem de erro abaixo:

 Resultado:
 Msg 945, Level 14, State 2, Line 1
 Database 'FATEC' cannot be opened due to inaccessible files or insufficient memory or disk space. See the SQL Server errorlog for details.
*/

USE FATEC
Go

-- Verificando o Status do Banco de Dados - FATEC --
SELECT databasepropertyex ('FATEC', 'STATUS');


-- Tentando resolver o problema com Detach e depois Attach --
EXEC SP_Detach_db 'FATEC'
Go

/*O Detach ocorreu, apesar do erro alertando o estado inconsistente do banco de dados. 
Verifique com o comando abaixo:
*/

SELECT * FROM sys.databases 
WHERE NAME = 'FATEC'

/*Ao tentar realizar um Attach com base na system stored procedure SP_Attach_Db a opera��o ir� falhar, 
   devido ao arquivo de log estar neste momento corrompido.
*/
  
-- For�ando o Attach do Banco de Dados - FATEC -- 
EXEC SP_Attach_Db @dbname = 'FATEC',
@filename1 = N'C:\Users\Junior Galv�o\Desktop\Fatec\FATEC-Dados.mdf',
@filename2 = N'C:\Users\Junior Galv�o\Desktop\Fatec\FATEC-Log.ldf'
Go

/*Temos ainda mais uma op��o, mas que n�o ser� a solu��o, tentar criar novamente o nosso 
    Banco de Dados FATEC, fazendo o anexo e reconstru��o do Arquivo de Log.
    
    Para isso vamos utilizar a op��o ATTACH_Rebuild_Log
*/

CREATE DATABASE FATEC ON
 (NAME = FATEC_Dados, 
  FILENAME = N'C:\Users\Junior Galv�o\Desktop\Fatec\FATEC-Dados.mdf')
  FOR ATTACH_REBUILD_LOG
Go

/* Primeira for�a de Recupera��o do Banco de Dados - FATEC --
--1) Mover os arquivos de dados e log do banco FATEC para outra pasta.

--2) Criar um novo banco com o mesmo nome (FATEC) e interromper o servi�o do SQL Server, atrav�s do comando:
*/

CREATE DATABASE FATEC
SHUTDOWN
Go

/*3) Apagar o arquivo de log e copiar o arquivo de dados que voc� salvou no item 1, 
por cima do arquivo novo criado no item 2 acima.
*/

-- Alterando o Status do Banco para Emergency e Limitando Acesso dos Usu�rios --
Alter Database FATEC
 SET Emergency, Single_User, Read_Only
Go 

-- Reperando o Banco de Dados atrav�s do comando DBCC CheckDB --
DBCC CHECKDB (FATEC, REPAIR_ALLOW_DATA_LOSS) 
 WITH NO_INFOMSGS, ALL_ERRORMSGS
Go

-- Alterando o Status do Banco para OnLine e Liberando Acesso dos Usu�rios --
Alter Database FATEC
 SET Online, Multi_User, Read_Write
Go

-- Consultando o Banco de Dados --
USE TesteDB
Go

Select * From Clientes
Go