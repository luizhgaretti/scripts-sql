-- Muda o contexto do banco de dados
USE BDSSD

-- Insere os dados de Pedidos
INSERT INTO CORP.Pedidos (PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID)
VALUES (3,'20081215',1,2,1)

INSERT INTO CORP.Pedidos (PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID)
VALUES (4,'20081216',2,2,1)

INSERT INTO CORP.Pedidos (PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID)
VALUES (5,'20081218',2,1,1)

INSERT INTO CORP.Pedidos (PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID)
VALUES (6,'20081220',2,2,2)