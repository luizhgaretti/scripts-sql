--============================================
--				BCP OUT
--============================================
--> GERAR O SCRIPT DE BCP OUT (OBS: -T SOMENTE PARA SQL SERVER) (MUDAR NOME DA BASE E USUARIO)
	Select 'bcp TesteBCP.dbo.' + name + ' out ' + '"D:\Resultados\' + name + '.txt" -T -SWKS322 -c -t[#] -r[@]'
	From Sysobjects
	Where Type = 'U'
	GO	
		-- OBSERVAÇÕES --
			--> Colocar o caminho do BCP (C:\Program Files\Microsoft SQL Server\110\Tools\Binn)
			--> Criar um .bat com os script gerados

--> EXECUTA SCRIPT GERADO ANTERIORMENTE - BCP OUT
	-- Executar pelo CMD: bcp.bat >"D:\bcpout.txt" 

--> GERAR SCRIPT DE CRIAÇÃO DAS TABELAS
	-- Olhar os FileGroups
	-- View vInscricaoMunicipalAtiva

--> GERAR SCRIPT DE CRIAÇÃO DAS FOREIGN KEYS

--> GERAR SCRIPT DE CRIAÇÃO DOS INDICES
	-- Os indices já são criados junto com as Tabelas

--> GERAR SCRIPT DE CRIAÇÃO DOS TRIGGERS
	-- Separar as Trigger do Script de Criação das Tabelas

--> SELECIONANDO OS MAIORES INDICES
	Select object_name(id), rowcnt, dpages*8 as Tamanho 
	From sysindexes
	Where indid in (1,0) and objectproperty(id,'isusertable')=1
	Order By rowcnt DESC


--============================================
--				BCP IN
--============================================
--> GERAR OS SCRIPTS DE BCP IN (OBS: -T SOMENTE PARA SQL SERVER) - OK
	Select Case When
		(Select object_name(id) from syscolumns C where status = 128 and C.id = O.object_id) = O.name 
		then 'bcp iss_build.dbo.' + O.name + ' in ' + '"D:\BCP\OUT\' + O.name + '.txt" -SMETA\META01 -T -c -t[#] -r[@] -E' 
		else 'bcp iss_build.dbo.' + O.name + ' in ' + '"D:\BCP\OUT\' + O.name + '.txt" -SMETA\META01 -T -c -t[#] -r[@]' end
	From Sys.objects O
	Where Type = 'U'
		-- OBSERVAÇÕES --
			--> Colocar o caminho do BCP (C:\Program Files\Microsoft SQL Server\110\Tools\Binn)
			--> Criar um .bat com os script gerados

--> DROPAR AS FOREIGN KEYS - OK
	Select 'ALTER TABLE ' + T.name + ' DROP CONSTRAINT ' + F.name + char(10) + 'GO' + char(10)
	From sys.foreign_keys F, Sysobjects T
	Where F.parent_object_id = T.id
		-- OBSERVAÇÔES --
			-- Verificar se ficou alguma FK sem DROPAR
				-- Select * From Sys.foreign_keys


--> DROPAR AS TRIGGERS - OK
		Select 'DROP TRIGGER ' + T.name + Char(10) + 'GO' + char(10)
		From sys.triggers T, sys.objects O
		Where T.parent_id = O.object_id
		-- Select * From sys.triggers


--> DROPAR AS TABELAS - OK 
	Select 'Drop Table ' + name + char(10) + 'GO' + char(10)
	From sysobjects
	Where Type = 'U'
		-- OBSERVAÇÕES --
			-- Excluir a view vInscricaoMunicipalAtiva que está relacionada a tabela INSCRIÇÃOMUNICIPAL(Obs: Guardar o Script de Criação da view)
				-- DROP VIEW vInscricaoMunicipalAtiva


 --> RECRIAR AS TABELAS -- OK
	-- Executar o script de criação das Tabelas
	-- Neste passo também é recriado as Triggers e Indices
	-- Caso tenha excluido a view vInscricaoMunicipalAtivac, recria-la agora
	

--> DESABILITAR AS TRIGGERS - OK
	-- Verificar se existe Trigger criada na base, Caso exista desabita-las
	-- Select * from sys.triggers


--> DROPAR OS MAIORES INDICES - OK
	-- Execluir os maiores indices
	-- Montar script


--> EXECUTAR O SCRIPT DE BCP IN - OK
	-- Executar o .bat criado com os script do BCP IN
	-- Executar pelo CMD: bcp.bat >"D:\Log\bcpin.txt" 


--> HABILITAR AS TRIGGERS - 
	-- Habilitar ou Recriar as Triggers


--> RECRIAR OS MAIORES INDICES
	-- Caso algum indice foi recriado, Recriar agora


--> RECRIAR AS FOREIGN KEYS
	-- Executar o Script de Criação das FKs


--> ATUALIZAR STATISTICS
	Select 'update statistics ' + name + char(10) + ' go' + char(10)
	From Sysobjects
	Where Type = 'U'
	go


--> PROCEDURE DE PERMISSÃO DE USUÁRIOS
	--	Executar procedure de permissão
	--- ??