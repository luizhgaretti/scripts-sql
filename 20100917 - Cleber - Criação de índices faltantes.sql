use master

--Caso não exista a tabela é criada a tabela que mantém o log dos índices criados
if ISNULL( ( select count(1) from sysobjects where xtype='U' and name = 'Tb_Capta_LogIndicesCriados' ),0) =0
begin
	create table Tb_Capta_LogIndicesCriados
	(
	 comando varchar(max) not null
	 ,dt_log datetime not null
	)
end
--Caso não exista a tabela é criada a tabela que mantém o log dos índices criados


if ISNULL( ( select count(1) from sysobjects where xtype='U' and name = 'Tb_dba_comandos' ),0) >0 drop table Tb_dba_comandos
SELECT  'CREATE INDEX missing_index_' 
                  + CONVERT (varchar, mig.index_group_handle) 
                  + '_'         
                  + CONVERT (varchar, mid.index_handle)        
                  + ' ON ' 
                  + mid.statement        
                  + ' (' + ISNULL (mid.equality_columns,'')        
                  + CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns IS NOT NULL 
                        THEN ',' 
                             ELSE '' 
                        END         
                  + ISNULL (mid.inequality_columns, '')        
                  + ')'        
                  + ISNULL (' INCLUDE (' 
                  + mid.included_columns 
                  + ')', '') AS comando
                  , ROW_NUMBER() over ( order by mig.index_group_handle ) nOrdem
into Tb_dba_comandos                  
FROM
(
      SELECT (user_seeks * avg_total_user_cost * (avg_user_impact * 0.01)) AS index_advantage
               , migs.* 
      FROM sys.dm_db_missing_index_group_stats migs      
) AS migs_adv
INNER JOIN sys.dm_db_missing_index_groups AS mig       
      ON migs_adv.group_handle = mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details AS mid      
      ON mig.index_handle = mid.index_handle
where round(index_advantage,0) > 10000
ORDER BY migs_adv.index_advantage desc

declare @catch varchar(max)
declare @sql varchar(max)
declare @nOrdem int
set @nOrdem = ( select MIN(nOrdem) from Tb_dba_comandos )
while @nOrdem <= ( select MAX(nOrdem) from Tb_dba_comandos )
begin
	begin try
		set @sql = isnull(( select c.comando from Tb_dba_comandos c where c.nordem = @nOrdem ),'')
		exec(@sql)
		
		if @@ERROR = 0
		insert into Tb_Capta_LogIndicesCriados ( comando, dt_log )
		select
		c.comando
		,GETDATE()
		from
		Tb_dba_comandos c
		where
		nordem = @nOrdem
		
	end try
	begin catch
		set @catch = 'Não foi possível criar o índice ' + ( select comando from Tb_dba_comandos where nordem = @nOrdem) 
		print @catch
	end catch
	set @nOrdem = @nOrdem + 1
end