-------------------------------
--    Utilizando SEQUENCE    --
-------------------------------


-- Criando SEQUENCE
CREATE SEQUENCE [dbo].[Sequence_Teste]  AS [int]
START WITH 1 
INCREMENT BY 2
MAXVALUE 100
CYCLE
GO


-- Criando Tabela
Create Table dbo.SequenceTeste
(
	ID int,
	Descricao varchar(50) not null,
	Constraint pk_SequenceTeste Primary Key (ID)
)
GO


-- Criando Procedure que usar� a SEQUENCE
Create Procedure Teste_Proc_Sequence (@Descricao varchar(50))
AS
Begin
	Insert into SequenceTeste
	Values (NEXT VALUE FOR [Sequence_Teste], @Descricao)
END


-- Executando a Procedure
Execute Teste_Proc_Sequence 'Luiz Henrique'


-- Select na tabela para validar a SEQUENCE
Select * from SequenceTeste

-- Visualiza todas as Sequences criadas na base
Select * From sys.sequences


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


- MINVALUE e MAXVALUE: delimitam o limite da SEQUENCE com seu respectivo valor m�ximo e m�nimo. Caso o valor n�o seja inserido, ser� atribu�do o valor do DataType escolhido.

- INCREMENT: define em quantos n�meros ser�o incrementadas as sequencias. No exemplo da imagem acima, ser� realizado o incremento de 1 em 1.

- CYCLE: A propriedade do objeto CYCLE permite come�ar novamente um ciclo a partir do momento que a propriedade MINVALUE e MAXVALUE for atingida.

- CACHE: pelo fato de desempenho, o SQL Server pr�-aloca os n�meros sequencias pela propriedade CACHE, sendo que o valor padr�o para esta � 15, significando que valores de 1 a 15 ser�o disponibilizados na mem�ria a partir do �ltimo valor armazenado em cache.