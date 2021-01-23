-- Muda o contexto do banco de dados
USE BDSSD

-- Cria as chaves primárias
ALTER TABLE RH.Empregados ADD CONSTRAINT PK_Empregado PRIMARY KEY (EmpregadoID)
ALTER TABLE MKT.Promocoes ADD CONSTRAINT PK_Promocao PRIMARY KEY (PromocaoID)
ALTER TABLE PROD.Produtos ADD CONSTRAINT PK_Produto PRIMARY KEY (ProdutoID)
ALTER TABLE CORP.Clientes ADD CONSTRAINT PK_Cliente PRIMARY KEY (ClienteID)
ALTER TABLE CORP.Pedidos ADD CONSTRAINT PK_Pedido PRIMARY KEY (PedidoNum)

-- Cria os relacionamentos
ALTER TABLE PROD.Produtos ADD CONSTRAINT FK_Produto_Promocao
	FOREIGN KEY (PromocaoID) REFERENCES MKT.Promocoes (PromocaoID)

ALTER TABLE CORP.Pedidos ADD CONSTRAINT FK_Pedido_Empregado
	FOREIGN KEY (EmpregadoID) REFERENCES RH.Empregados (EmpregadoID)
	
ALTER TABLE CORP.Pedidos ADD CONSTRAINT FK_Pedido_Produto
	FOREIGN KEY (ProdutoID) REFERENCES PROD.Produtos (ProdutoID)
	
ALTER TABLE CORP.Pedidos ADD CONSTRAINT FK_Pedido_Cliente
	FOREIGN KEY (ClienteID) REFERENCES CORP.Clientes (ClienteID)
	
-- Faz um Backup do FILEGROUP Primary
BACKUP DATABASE BDSSD FILEGROUP = 'PRIMARY'
TO DISK = 'C:\SSD\Backups\BDSSD_FGPrimary.BAK'

-- Visualiza o Diagrama