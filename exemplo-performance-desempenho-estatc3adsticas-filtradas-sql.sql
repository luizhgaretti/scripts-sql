-- Criando a Tabela Cidades --
Create Table Cidades
 (Codigo Int, 
   Nome VARCHAR(100), 
   Estado Char(2)) 
Go

-- Criando os Índices Clusterizados para Tabela Cidades--
Create Clustered Index Ind_Cidades_Codigo ON Cidades(Codigo) 
Go

-- Criando um novo índice para Tabela Cidades --
Create Index Ind_Cidade_Nome ON Cidades(Nome) 
Go

-- Criando novas Estatísticas para a Tabelas Cidades --
Create Statistics Sts_Cidade_Codigo_Nome ON Cidades(Codigo, Nome) 
Go 

-- Criando a Tabela Vendas --
Create Table Vendas
  (Codigo Int, 
    NumPedido Int, 
    Quantidade Int) 
Go

-- Criando os Índices Clusterizados para Tabela Vendas --
Create Clustered Index Ind_Vendas_Codigo_NumPedido ON Vendas(Codigo,NumPedido) 
Go

-- Inserindo dados no Tabela Cidades --
Insert Cidades Values(1, 'São Roque', 'SP') 
Insert Cidades Values(2, 'São Roque da Fartura', 'MG') 
Go 

-- Bloco para inserção de registros na Tabela Vendas --
Set NoCount On

Insert Vendas Values(1, 1, 100) 

Declare @Contador INT 
Set @Contador = 2 

While @Contador <= 1000 
 Begin 

  INSERT Vendas VALUES (2, @Contador, @Contador*2) 

  SET @Contador +=1 

End 
Go 

-- Atualizando as Estatísticas para as Tabelas Cidades e Vendas, realizando um FullScan --
Update Statistics Cidades WITH FullScan 
Go

Update Statistics Vendas WITH FullScan 
Go

-- Consultados os Dados Armazenados nas Tabelas Cidades e Vendas --
SELECT V.NumPedido FROM Cidades C Inner Join Vendas V 
                                               On C.Codigo = V.Codigo
WHERE C.Nome='São Roque' 
OPTION (Recompile) 


-- Criando novas estatísticas para as Tabela Cidades, utilizando as Estatísticas Filtradas --
CREATE STATISTICS StsFiltrada_Cidades_SaoRoque ON Cidades(Codigo) 
WHERE Nome = 'São Roque' 
GO 

CREATE STATISTICS StsFiltrada_Cidades_Mairinque ON Cidades(Codigo) 
WHERE Nome = 'Mairinque' 
GO

-- Consultados os Dados Armazenados nas Tabelas Cidades e Vendas --
SELECT V.NumPedido FROM Cidades C Inner Join Vendas V 
                                               On C.Codigo = V.Codigo
WHERE C.Nome='São Roque' 
OPTION (Recompile) 