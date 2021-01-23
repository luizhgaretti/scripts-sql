-- Muda o contexto do banco de dados
USE BDSSD

-- Muda a nulabilidade das colunas
SET ANSI_NULL_DFLT_OFF ON

-- Cria a tabela de Empregados
CREATE TABLE RH.Empregados (
	EmpregadoID INT, EmpregadoNome VARCHAR(50)) ON [RH]

-- Cria a tabela de Promocoes
CREATE TABLE MKT.Promocoes (
	PromocaoID INT,
	PromocaoNome VARCHAR(50),
	Desconto DECIMAL(4,2)) ON [MKT]

-- Cria a tabela de Produtos
CREATE TABLE PROD.Produtos (
	ProdutoID INT, PromocaoID INT,
	ProdutoNome VARCHAR(50),
	ProdutoPreco DECIMAL(6,2)) ON [PROD]

-- Cria a tabela de Clientes
CREATE TABLE CORP.Clientes (
	ClienteID INT, ClienteNome VARCHAR(50)) ON [CORP]

-- Cria a tabela de Pedidos
CREATE TABLE CORP.Pedidos (
	PedidoNum INT, DataPedido DATE,
	EmpregadoID INT, ProdutoID INT,
	ClienteID INT) ON [CORP]