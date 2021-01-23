-- Muda o contexto do banco de dados
USE BDSSD

-- Insere os dados de Pedidos
INSERT INTO CORP.Pedidos (PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID)
VALUES (1,'20081210',1,1,1)

INSERT INTO CORP.Pedidos (PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID)
VALUES (2,'20081211',1,1,2)