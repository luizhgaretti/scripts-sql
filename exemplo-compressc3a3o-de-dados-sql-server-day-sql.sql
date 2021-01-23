-- Criando o Banco de Dados SQLServerDay --
Create Database SQLServerDay
Go

Use SQLMagazine
Go

Listagem 2. Cria��o das tabelas Eventos e EventosRealizados
-- Bloco 1 --
Create Table Eventos
 (Codigo SmallInt Identity(1,1) Primary Key,
  Descricao Varchar(50),
  Edicao Int Default(1),
  AnoPublicacao Int Default(2009))
 On [Primary]
Go

-- Bloco 2 --
Create Table EventosRealizados
 (Codigo SmallInt Identity(1,1) Primary Key,
  Descricao Varchar(50),
  Edicao Int Default(1),
  AnoPublicacao Int Default(2009))
 On [Primary] 
WITH (DATA_COMPRESSION = ROW) 
Go

Listagem 3. Inserindo dados nas tabelas Eventos e EventosRealizados
-- Bloco 1 --
Declare @Cont Int

Set @Cont=1

While (@Cont <= 10000)
  Begin
    Insert Into Eventos Values ('SQL Server Day',@Cont,2009)
    Set @Cont +=1;
  End
Go

-- Bloco 2 --
Declare @Cont Int

Set @Cont=1

While (@Cont <= 10000)
  Begin
    Insert Into EventosRealizados Values ('SQL Server Day',@Cont,2009)
    Set @Cont +=1;
  End
Go

Listagem 4. Consultando o espa�o f�sico ocupado por cada tabela
-- Bloco 1 --
sp_spaceused 'Eventos'
Go

-- Bloco 2 --
sp_spaceused 'EventosRealizados'
Go


Listagem 5. Alterando o n�vel de compacta��o da tabela EventosRealizados
-- Bloco 1 --
Alter Table EventosRealizados
Rebuild With (DATA_COMPRESSION=PAGE)
Go


Listagem 6. Consultando o espa�o f�sico ocupado por cada tabela em n�vel de pagina 
-- Bloco 1 --
sp_spaceused 'Eventos'
Go

-- Bloco 2 --
sp_spaceused 'EventosRealizados'
Go

-- Bloco 3 -- 
Select * from EventosRealizados
Where Edicao=69

Select * from EventosRealizados
Where Edicao in (66,68,70)

Listagem 7. Sintaxe da sp_estimate_data_compression_savings 
-- Bloco 1 --
sp_estimate_data_compression_savings 
       [ @schema_name = ] 'schema_name'  
     , [ @object_name = ] 'object_name' 
     , [@index_id = ] index_id 
     , [@partition_number = ] partition_number 
     , [@data_compression = ] 'data_compression' 
[;]


Listagem 8. Obtendo os resultados da estimativa de compacta��o em n�vel de linha
-- Bloco 1 �

EXEC sp_estimate_data_compression_savings 'dbo', 
'EventosRealizados', NULL, 
NULL, 
'ROW'

Listagem 9. Obtendo os resultados da estimativa de compacta��o em n�vel de p�gina
-- Bloco 1 �

EXEC sp_estimate_data_compression_savings 'dbo',
'EventosRealizados', NULL, 
NULL, 
'PAGE'

