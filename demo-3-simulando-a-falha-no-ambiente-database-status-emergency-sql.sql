-- Conecta-se ao SQL Server no banco Master --
Use master
Go

-- Alterando o Status do Banco para Emergency e Limitando Acesso dos Usu�rios --
SP_DBoption 'FATEC', 'Dbo Use Only', True
Go

SP_DBoption 'FATEC','Single_User', True
Go

Alter Database FATEC
 SET Emergency, Single_User, Read_Write
Go 

-- Verificando o Status do banco --
Use FATEC
Go

Select * from Clientes

SELECT DATABASEPROPERTYEX('FATEC', 'Status') As Status, 
             DATABASEPROPERTYEX('FATEC', 'Recovery') As 'Modelo de Recupera��o',
             DATABASEPROPERTYEX('FATEC', 'UserAccess') As 'Forma de Acesso', 
             DATABASEPROPERTYEX('FATEC', 'Version') As 'Vers�o' 
Go

-- Verificando a integridade Fsica e L�gica do Banco, Reconstru�ndo os Dados Perdidos --
DBCC CheckDB ('FATEC',Repair_Allow_Data_Loss)
Go

-- Alterando o Status do Banco para OnLine e Liberando Acesso dos Usu�rios --
SP_DBoption 'FATEC', 'Dbo Use Only', False
Go

SP_DBoption 'FATEC','Single_User', False
Go

Alter Database FATEC
 SET OnLine, Multi_User, Read_Write
Go 

-- Verificando o Status do banco -- 
SELECT DATABASEPROPERTYEX('FATEC', 'Status') As Status, 
             DATABASEPROPERTYEX('FATEC', 'Recovery') As 'Modelo de Recupera��o',
             DATABASEPROPERTYEX('FATEC', 'UserAccess') As 'Forma de Acesso', 
             DATABASEPROPERTYEX('FATEC', 'Version') As 'Vers�o' 
Go