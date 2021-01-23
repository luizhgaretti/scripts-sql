-- Muda o contexto do banco de dados
USE BDSSD

-- Insere os dados de Empregado
INSERT INTO RH.Empregados (EmpregadoID, EmpregadoNome)
VALUES (1,'Rog�rio')

-- Faz um Backup do FILEGROUP RH
BACKUP DATABASE BDSSD FILEGROUP = 'RH'
TO DISK = 'C:\SSD\Backups\BDSSD_FGRH.BAK'

-- Insere mais um empregado ap�s o Backup
INSERT INTO RH.Empregados (EmpregadoID, EmpregadoNome)
VALUES (2,'Adalton')