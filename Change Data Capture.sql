/*************************************************************
					CHANGE DATA CAPTURE
**************************************************************/
-- OBS: Essa Feature est� disponivel na Vers�o SQL Server 2008 Enterprise ou Posterior
-- O SQL Agent Precisa est� executando


-- No primeiro passo iremos criar a tabela que ser� utilizada em nossos testes:
 CREATE TABLE Funcionario 
 (
	CodigoFuncionario	INT	NOT NULL,
	Nome				VARCHAR(60),
	Idade				INT,
	NumeroCPF			CHAR(11)
);
GO

ALTER TABLE Funcionario
	ADD CONSTRAINT PK_CodFunc PRIMARY KEY (codigoFuncionario);
go



-- Agora ativamos o CDC na base de dados e na tabela Funcionario
--- Habilita CDC banco
EXEC sys.sp_cdc_enable_db;
GO



-- Habilita CDC na tabela Funcionario
 EXECUTE sys.sp_cdc_enable_table
@source_schema = 'dbo',
@source_name = 'Funcionario',
@role_name = 'roleCDC';


/*
Ao habilitar o CDC, o SQL Server cria jobs que ser�o executados pelo SQL Server Agent. 
Estes jobs ser�o os respons�veis pelo registro das altera��es nas tabelas do CDC; logo, 
para o CDC funcionar corretamente, lembre-se que o SQL Server Agent deve estar em execu��o.
*/


-- Com o CDC habilitado, vamos popular a tabela Funcionario:
-- Carga de dados
 INSERT INTO Funcionario (codigoFuncionario, nome, idade, numeroCPF)
VALUES	(1, 'Silas Mendes', 29, '08643238736'),
		(2, 'Antonio Robberto', 36, '04686398765'),
		(3, 'Joana Maxado', 45, '52341369844'),
		(4, 'Roberto',null, null),
		(5, 'Armando Filo', null, '41397601223');


/*
Agora j� podemos consultar a tabela do CDC que armazena as altera��es na tabela Funcionario:
Observe que a tabela do CDC est� no esquema CDC.
Lembre-se que este � um processo ass�ncrono, portanto ao executar o comando abaixo, pode ser que a 
tabela ainda n�o tenha sido atualizada; neste caso, repita a execu��o do comando.
*/


-- Essa Tabela � criada automaticamente.
SELECT * FROM cdc.dbo_Funcionario_CT;


/*No resultado s�o retornadas 9 colunas. Neste momento atente-se � coluna __$operation. 
Note que ela est� com o valor: 2. O valor 2 significa que estes registros foram resultado de inser��es.
Vamos continuar manipulando os dados para verificar os reflexos das altera��es nas tabelas do CDC:*/



-- UPDATEs na tabela Funcionario
UPDATE Funcionario SET Nome = 'Antonio Roberto'
WHERE codigoFuncionario = 2;
 
UPDATE Funcionario SET Nome = 'Joana Machado'
WHERE codigoFuncionario = 3;
 
UPDATE Funcionario SET Nome = 'Roberto Nespolitano', Idade = 18, NumeroCPF = '08468354173'
WHERE codigoFuncionario = 3;


/*Agora observe que aumentou a quantidade de registros da tabela do CDC. Al�m das inser��es 
(__$operation = 2) temos tamb�m o ANTES e DEPOIS nas opera��es de UPDATE. Observe agora que, 
onde o campo __$operation � igual a 3 o registro cont�m o estado antes do UPDATE, 
e onde o campo __$operation = 4 temos o estado do registro ap�s o UPDATE.*/



--Para finalizar nosso exemplo, vamos realizar uma exclus�o e verificar como essa altera��o � registrada:
DELETE FROM Funcionario
WHERE codigoFuncionario IN (2,3);

SELECT * FROM cdc.dbo_Funcionario_CT;



-- Consultas
Select * From sys.databases
	-- is_cdc_enabled	1- Ativo para o Database
	--					0- N�o Ativo para o Database 



-- Datativar o Change Data Capture para o Banco de dados
Use Banco
GO

EXECUTE sys.sp_cdc_disable_db;
GO




/*
CONCLUS�O
Como observamos, basicamente s�o necess�rios 4 passos para utilizar o CDC:
�	Utilizar a vers�o Enterprise (ou superior) do SQL Server 2008;
�	O servi�o SQL Server Agent deve estar ativo;
�	Ativar o CDC no banco de dados utilizando a procedure sp_cdc_enable_db;
�	Ativar o CDC nas tabelas que ser�o monitoradas utilizando a procedure sp_cdc_enable_table.
Vimos tamb�m que na tabela de registro do CDC temos diversos valores para o campo __$operation, sendo: 
Comando DML	__$operation
DELETE				1
INSERT				2
Antes do UPDATE		3
Depois do UPDATE	4
*/
