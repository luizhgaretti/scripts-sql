/*****************************************
			Alterando o Owner 
******************************************/

-- Alterando OWNER dos Databases
Create Table #Temp
(
	Banco		Varchar(30),
	Owners	Varchar(30))
GO


Insert #Temp (Banco, Owners)
	SELECT  DB.Name as Banco,
			SP.Name as Owner
	FROM sys.Databases DB INNER JOIN sys.Server_Principals SP
		ON DB.Owner_Sid = SP.sid
	WHERE SP.name <> 'sa'
GO


-- Gera as Scripts de Saídas 
	-- (Obs: recomendado deixar SA)
Select 'Use ' + Banco + char(10) + 'GO' + char(10) + 'Exec sp_changedbowner ' + '''' + 'RGM\luiz.garetti' + '''' + char(10) + 'GO'
From #Temp
GO