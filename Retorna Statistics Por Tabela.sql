-- Lista todas as Staticas da Tabela
Select Name, STATS_DATE(Id, indid) DataAtualizacao
From sysindexes
Where id = Object_id('Processador')



-- Visualiza Statistics  --> Parametro (Tabela, Index)
DBCC Show_Statistics ('Tabela1','idx_Campo1')


-- Lista objetos de statiscas para uma tabela
exec sp_helpstats 'Pessoa', 'all'