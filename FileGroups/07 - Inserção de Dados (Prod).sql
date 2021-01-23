-- Muda o contexto do banco de dados
USE BDSSD

-- Insere os dados de Produto (Promocao Natal)
INSERT INTO PROD.Produtos (ProdutoID, PromocaoID, ProdutoNome, ProdutoPreco)
VALUES (1, 1, 'Pen Drive', 80)

-- Faz um Backup do FILEGROUP PROD
BACKUP DATABASE BDSSD FILEGROUP = 'PROD'
TO DISK = 'C:\SSD\Backups\BDSSD_FGPROD.BAK'

-- Insere mais um produto após o Backup
-- Insere os dados de Produto (Promocao Natal acima de 1000 reais)
INSERT INTO PROD.Produtos (ProdutoID, PromocaoID, ProdutoNome, ProdutoPreco)
VALUES (2, 2, 'Notebook', 1200)