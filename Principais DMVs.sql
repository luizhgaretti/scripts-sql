/****************************************************************************
			Principais DMVs - SQL SERVER
*****************************************************************************/


/*********************
    CATEGORIAS
*********************/

--> sys.dm_db_*: Fornecem informações sobre utilização de espaço e indice.

--> sys.dm_exec_*: Fornecem informações sobre as consultas correntemente em execução, assim como sobre as consultas que ainda estão na cache
		       de consulta. Você também pode usar conjunto de DMVs para solucionar problemas de obstrução, assim como ver o ultimo tipo 
		       de espera atribuido a um pedido.

--> sys.dm_io_*: São usadas para avaliar o desempenho do subsistema do disco e determinar se existem gargalos de disco.

--> sys.dm_os_*:
	


/*********************
  PRINCIPAIS DMVs
**********************/

--> sys.dm_os_wait_stats: Lista o valor agregado da espera de sinal e do tempo de espera para cada tipo de espera. A Espera de sinal junto com o tempo de espera
é um valor agregado desde a ultima vez que as statisticas foram zeradas.

--> sys.dm_db_index_usage_stats: Fornece informações sobre utilização de cada indice, com o numero de vezes utilizados e quando foi utilizado pela ultima vez.

--> sys.dm_db_index_operational_stats:É uma função que recebe 4 parametros opcionais: database_ID, object_ID, indexe_ID e partition_ID. Essa função retorna
statatisticas de bloqueio, fechamento e acesso para cada indexe que podem ajuda-lo a determinar o quanto um indexe está sento usado expressivamente. Estão
função tambpem ajuda a diagnosticar problemas de disputa resultados de bloqueio e fechamento.

--> sys.dm_index_physical.stats:É uma função que recebe 5 paramentros database_ID, Object_ID, Indexe_ID, partition_ID e Mode. A função retorna estatisticas de
tamanho e fragmentação para cada indice e deve ser a principal fonte para se determinar quando um indice precisa ser desfragmentado.

--> sys.dm_db_missing_index_details:Contem estatisticas agregadas sobre quantas vezes uma falta de indice foi gerada para determinada possibilidade de indice,
que você pode usar para avaliar se deve criar o indice.

--> sys.dm_exec_connections: Contem uma linha para cada conexão com a instancia. Nessa view, você descobrir quando a conexão foi estabelecida, junto com 
propriedades de conexão e configuração de criptografia. Também retorna o nº total de leituras e grabações da conexão, assim com a ultima vez que uma leitura
ou gravação foi executada

--> sys.dm_exec_sessions: Contem uma linha para cada sessão atualmente autenticada, Alem das informações de login. essa DMV controla o estado atual de cada
opção de consulta possivel e o status atual da execução. Essa DMV também retorna a duração acumulada de leituras gravações CPU e consulta para a sessão.

--> sys.dm_exec_requests: Contem uma linha para cada pedido correntemente em execução na instancia. Você pode usar a coluna blocking_id para diagnosticar
problemas de disputa. Essa DMV também Contem o tempo de inicio de leituras e gravações e CPU. Também é possivel recuperar o comando que estão sendo executado,
junto com o identificador da instrução SQL e do plano de execução associado ao pedido.

--> sys.dm_exec_sql_text: O SQL armazena o plano de execução e o texto de cada consulta executada na cache, essa função retorna o texto da instrução SQL associada

--> sys.dm_exec_query_plan: Aceita um identificador de plano de execução e retorna plano em XML.

--> sys.dm_io_virtual_file_stats: Retorna statisticas sobre leituras e gravações de cada banco de dados.

--> sys.dm_io_virtual_stats: 

--> sys.dm_io_pending_Request: Contem uma linha para cada pedido que está esperando o subsistema de disco concluir um pedido de I/O.

--> sys.dm_db_mirroring_auto_page_repair: Essa view retorna informações caso uma pagina danificada foi Substituída pelo Database Mirroring.

