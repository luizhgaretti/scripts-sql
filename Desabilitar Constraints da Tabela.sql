-- (Script 01) Gerando o Scrip para desabilitar todas as constraints de todas as tabelas
Select	'Alter Table '+ name + ' NoCheck Constraint ALL'
From	Sys.tables where type = 'U'
Order by name