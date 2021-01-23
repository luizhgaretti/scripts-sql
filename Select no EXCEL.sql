use BaseTeste

/*   Para o comando abaixo dar certo tem que esta habilitado a op��o Ad Hoc Remote Queries,
 * em Surface Area Configuration > Surface Area Configuration for Features */

SELECT *
into #TbTeste -- Gera em uma tabela Tempor�ria
FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0','Data Source=D:\TbTeste.xls;Extended Properties=Excel 8.0')...[Plan1$]

-- Obser.: A primeira linha do arquivo do Excel deve ter o nome das colunas

-- Insere na tabela original a tabela tempor�ria
insert into TbTeste 
   select * from #TbTeste

-- Auxiliares
select * from TbTeste
select * from #TbTeste
drop table #TbTeste -- Se preferir pode apagar a tabela tempor�ria, mas o SQL Server faz isso quando � reiniciado.

-- Por Antonio Alex