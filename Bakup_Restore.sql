/***************************************
	Rotina: Backup e Restore
	Autor: Luiz Henrique (o cara) rsrs
	Data: 26/08
****************************************/

-- BACKUP FULL
	-- OBS: Copia todas as paginas de dados do database junto com o Log
	--		O Backup FULL é a partida inicial para restaurar um Backup Differential ou de Log.
Backup Database TesteBkp
To Disk = 'D:\TesteSQLServer\Backups\TesteBkp1.bak'
With stats
GO


-- BACKUP DIFERENTIAL
	-- OBS: Faz a copia de todas as modificações ocorridas depois do ultimo Backup FULL,
    --   	possui o objetivo de reduzir o numero de backup de LOG que precisam ser recuperados.
Backup Database [AdventureWorks2012]
To Disk = 'D:\TesteSQLServer\Backups\TesteBkp1.bak'
With stats, DIFFERENTIAL
GO

-- BACKUP LOG
	-- OBS: O backup de log captura todas as transações efetivadas no log desde o último backup de log ou backup full. 
	--	    Como o backup de log contém somente informações de alteração é necessário um ponto de partida 
	--		para utilizá-lo, que pode ser um backup full ou um backup diferencial.
Backup Log TesteBkp
To Disk = 'D:\TesteSQLServer\Backups\TesteBkplog1.trn'
With stats
GO



-- BACKUP EM STRIPES (FAIXAS)
	-- OBS: Utilizado em grande Databases, acelara o processo de backup dividindo em varios discos diferentes.
	-- No momento de restaurar é necessário ter todos os arquivos .bak, caso contratrio o Backup ficara com falha.
Backup database  DTB_GPV
TO Disk = 'D:\BACKUP\BKPSQLCOMP\DTB_GPV_0.bkp',
Disk = 'E:\BACKUP\BKPSQLCOMP\DTB_GPV_1.bkp',
Disk = 'A:\BACKUP\BKPSQLCOMP\DTB_GPV_2.bkp',
Disk = 'J:\BACKUP\BKPSQLCOMP\DTB_GPV_3.bkp',
Disk = 'G:\BACKUP\BKPSQLCOMP\DTB_GPV_4.bkp',
Disk = 'F:\BACKUP\BKPSQLCOMP\DTB_GPV_5.bkp'
With stats
GO





-- Restore Database Simples
Restore Database TesteBkp2
From Disk = 'D:\TesteSQLServer\Backups\TesteBkp1.bak'


-- Restore Database com MOVE e STANDY
Restore Database TesteBkp2
From Disk = 'D:\TesteSQLServer\Backups\TesteBkp1.bak'
With -- recovery,
Move 'TesteBkp' to 'D:\TesteSQLServer\TesteBkp2\TesteBkp2.mdf', Move 'TesteBkp_log' to 'D:\TesteSQLServer\TesteBkp2\TesteBkp_log2.ldf',
STANDBY =  N'D:\TesteSQLServer\TesteBkp2\TesteBkpStanby.bak',  NOUNLOAD,  STATS = 5



-- Restore Log Simples
Restore Log TesteBkp2
From Disk = 'D:\TesteSQLServer\Backups\TesteBkplog2.bak'


-- Restore log com STANDY
Restore Log TesteBkp2
From Disk = 'D:\TesteSQLServer\Backups\TesteBkplog2.bak'
With stats, 
STANDBY =  N'D:\TesteSQLServer\TesteBkp2\TesteBkpStanby.bak',  NOUNLOAD,  STATS = 5



-- Restore com Stripes
Restore Database <nome do banco> 
From	disk = '<caminho do bkp>',
	disk = '<caminho do bkp>'
with 
move '<nome lógico do mdf>' to '<caminho onde ficará o .mdf>',
move '<nome lógico do ldf>' to '<caminho onde ficará o .ldf>', 


--Exemplo:
Testore database MACCHIPS 
From 
disk = 'I:\CHANGE - 806719\MACCHIPS_0.bkp',
disk = 'J:\CHANGE - 806719\MACCHIPS_1.bkp'
with 
move	'macchips_data' 	 	 to 'I:\Dados\MSSQL\MACCHIPS\macchips_Data.mdf',
move	'macchips_log'		 to 'I:\Dados\MSSQL\MACCHIPS\macchips_Log.ldf', 
stats



---------------------------------
	-- OBSERVAÇÃO IMPORTANTE --
---------------------------------
-- O Tipo de Recovery Model está intimamente ligada com o Backup disponivel para cada Database
-- Para verificar o Recovery Model, execute o select abaixo:
	-- Select Name, Recovery_Model_Desc From sys.databases