/****************************************************************************
			Principais DMVs - SQL SERVER
*****************************************************************************/


/*********************
    CATEGORIAS
*********************/

--> sys.dm_db_*: Fornecem informa��es sobre utiliza��o de espa�o e indice.

--> sys.dm_exec_*: Fornecem informa��es sobre as consultas correntemente em execu��o, assim como sobre as consultas que ainda est�o na cache
		       de consulta. Voc� tamb�m pode usar conjunto de DMVs para solucionar problemas de obstru��o, assim como ver o ultimo tipo 
		       de espera atribuido a um pedido.

--> sys.dm_io_*: S�o usadas para avaliar o desempenho do subsistema do disco e determinar se existem gargalos de disco.

--> sys.dm_os_*:
	


/*********************
  PRINCIPAIS DMVs
**********************/

--> sys.dm_os_wait_stats: Lista o valor agregado da espera de sinal e do tempo de espera para cada tipo de espera. A Espera de sinal junto com o tempo de espera
� um valor agregado desde a ultima vez que as statisticas foram zeradas.

--> sys.dm_db_index_usage_stats: Fornece informa��es sobre utiliza��o de cada indice, com o numero de vezes utilizados e quando foi utilizado pela ultima vez.

--> sys.dm_db_index_operational_stats:� uma fun��o que recebe 4 parametros opcionais: database_ID, object_ID, indexe_ID e partition_ID. Essa fun��o retorna
statatisticas de bloqueio, fechamento e acesso para cada indexe que podem ajuda-lo a determinar o quanto um indexe est� sento usado expressivamente. Est�o
fun��o tambpem ajuda a diagnosticar problemas de disputa resultados de bloqueio e fechamento.

--> sys.dm_index_physical.stats:� uma fun��o que recebe 5 paramentros database_ID, Object_ID, Indexe_ID, partition_ID e Mode. A fun��o retorna estatisticas de
tamanho e fragmenta��o para cada indice e deve ser a principal fonte para se determinar quando um indice precisa ser desfragmentado.

--> sys.dm_db_missing_index_details:Contem estatisticas agregadas sobre quantas vezes uma falta de indice foi gerada para determinada possibilidade de indice,
que voc� pode usar para avaliar se deve criar o indice.

--> sys.dm_exec_connections: Contem uma linha para cada conex�o com a instancia. Nessa view, voc� descobrir quando a conex�o foi estabelecida, junto com 
propriedades de conex�o e configura��o de criptografia. Tamb�m retorna o n� total de leituras e graba��es da conex�o, assim com a ultima vez que uma leitura
ou grava��o foi executada

--> sys.dm_exec_sessions: Contem uma linha para cada sess�o atualmente autenticada, Alem das informa��es de login. essa DMV controla o estado atual de cada
op��o de consulta possivel e o status atual da execu��o. Essa DMV tamb�m retorna a dura��o acumulada de leituras grava��es CPU e consulta para a sess�o.

--> sys.dm_exec_requests: Contem uma linha para cada pedido correntemente em execu��o na instancia. Voc� pode usar a coluna blocking_id para diagnosticar
problemas de disputa. Essa DMV tamb�m Contem o tempo de inicio de leituras e grava��es e CPU. Tamb�m � possivel recuperar o comando que est�o sendo executado,
junto com o identificador da instru��o SQL e do plano de execu��o associado ao pedido.

--> sys.dm_exec_sql_text: O SQL armazena o plano de execu��o e o texto de cada consulta executada na cache, essa fun��o retorna o texto da instru��o SQL associada

--> sys.dm_exec_query_plan: Aceita um identificador de plano de execu��o e retorna plano em XML.

--> sys.dm_io_virtual_file_stats: Retorna statisticas sobre leituras e grava��es de cada banco de dados.

--> sys.dm_io_virtual_stats: 

--> sys.dm_io_pending_Request: Contem uma linha para cada pedido que est� esperando o subsistema de disco concluir um pedido de I/O.

--> sys.dm_db_mirroring_auto_page_repair: Essa view retorna informa��es caso uma pagina danificada foi Substitu�da pelo Database Mirroring.

