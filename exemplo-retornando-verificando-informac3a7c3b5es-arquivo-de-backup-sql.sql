Use Master

--Retorna Informa��es sobre as m�dias de backup --
Restore LabelOnly from Disk = 'C:\Backup\Backup-Simples-Criptografia.bak'

--Retorna Informa��es sobre os backups --
Restore HeaderOnly from Disk = 'C:\Backup\Backup-Simples-Criptografia.bak'

/* O comando RESTORE VERIFYONLY realiza uma checagem na integridade dos backups de um 
dispositivo, verificando se o mesmo � leg�vel, este comando n�o verifica a estrutura de 
dados existente dentro do backup. Se o backup for v�lido, o SQL Server retorna uma mensagem 
de sucesso.*/
Restore VerifyOnly from Disk = 'C:\Backup\Backup-Simples-Criptografia.bak'

-- Retorna informa��es sobre os arquivos de dados e log (*.mdf, *.ndf e *.ldf) armazenados em um dispositivo --
Restore FileListOnly from Disk = 'C:\Backup\Backup-Simples-Criptografia.bak'