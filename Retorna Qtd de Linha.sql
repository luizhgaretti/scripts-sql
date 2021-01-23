-- Retorna Quantide de Linha e Tamanho da Tabela
Select object_name(id), rowcnt, dpages*8 as Tamanho 
From sysindexes
Where indid in (1,0) and objectproperty(id,'isusertable')=1
Order By rowcnt DESC
