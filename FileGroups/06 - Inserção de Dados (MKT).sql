-- Muda o contexto do banco de dados
USE BDSSD

-- Insere os dados de Promocão
INSERT INTO MKT.Promocoes (PromocaoID, PromocaoNome, Desconto)
VALUES (1, 'Natal', 0.10)

-- Faz um Backup do FILEGROUP MKT
BACKUP DATABASE BDSSD FILEGROUP = 'MKT'
TO DISK = 'C:\SSD\Backups\BDSSD_FGMKT.BAK'

-- Insere mais uma promoção após o Backup
INSERT INTO MKT.Promocoes (PromocaoID, PromocaoNome, Desconto)
VALUES (2, 'Natal Acima de 1000 Reais', 0.15)