SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- Permite fazer Select em um registro, mesmo que esse registro esteja com transa��o aberta(Update, Delete)

-- Otimista

-- Como se existisse NOLOCK em todas as consultas

-- Sequencia para Teste
	-- Transa��o 1 => Update ID 1 (Sucesso)
	-- Transa��o 2 => Select ID 1 (Sucesso) -> Le o dado sujo, pois ainda n�o executado COMMIT ou ROLLBACK na Transa��o 1

-- Problemas de concorr�ncia:
	-- Dirty Read: SIM
	-- Non-repeatable Read: SIM
	-- Phantom Read: SIM



SET TRANSACTION ISOLATION LEVEL READ COMMITTED
 -- Default do SQL Server

 -- Nenhuma transa��o conseguir� obter um shared lock (de leitura) sobre recursos que tenham sido alterados (exclusive lock) por transa��es ainda n�o terminadas.

 -- Le o Registro e Libera o bloqueio.

-- Sequencia para Teste
	-- Transa��o 1 => Sucesso, como ainda n�o foi executado COMMIT\ROLLBACK a transa��o continuar com bloqueio de Altera��o (X) sobre o registro
			Begin Transaction
				Update Produto Set Valor = 40
				Where ID = 2	

	-- Transa��o 2 => Transa��o fica em espera, pois a Transa��o 1 est� com bloqueio de altera��o (X) sobre esse Registro
		Begin Transaction
		Select * From Produto
		Where ID = 2

-- Problemas de concorr�ncia:
	-- Dirty Read: N�O
	-- Non-repeatable Read: SIM
	-- Phantom Read: SIM




SET TRANSACTION ISOLATION LEVEL SNAPSHOT
-- Este n�vel de isolamento ficaria entre o n�vel READ UNCOMMITED e READ COMMITED. 
-- Permite a uma transa��o, a leitura de dados atualizados por uma segunda transa��o, por�m trazendo os dados originais (n�o alterados ainda). 
-- O SQL utiliza-se de uma c�pia tempor�ria dos dados originais neste caso, para o banco TempDB. 
-- Para usar este n�vel de isolamento em um banco de dados, execute o comando SET ALLOW_SNAPSHOT_ISOLATION ON.
	-- Alter Database AdventureWorks2012 SET ALLOW_SNAPSHOT_ISOLATION ON

-- Pega Ultima vers�o Comitada, Busca no Tempo DB

-- Sequencia para Teste
	-- Transa��o 1> Mudou o valor de 20 para 40, mas ainda n�o deu commit, ent�o por enquanto o ultimo valor commitado � 20
		Begin Transaction
		Update Produto Set Valor = 40
		Where ID = 2
	
	-- Transa��o 2	Retorna o ultimo valor commitado, no caso, 20(OBS: Mesmo com a Trans. aberta ele cosnegue fazer o select, porem, pegar o ultimo valor comitado)
		Begin Transaction
		Select * From Produto
		Where ID = 2



SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
-- Este modo � diferente do anterior porque os locks de leitura s�o mantidos at� ao final da transa��o. Isto significa que nenhuma transa��o pode alterar um recurso 
-- que tenha sido lido por uma transa��o n�o terminada. Por isso impede �non-repeatable reads�. No entanto, os �phantom reads� n�o s�o impedidos porque a nova transa��o 
-- pode ainda inserir registros que afetem a leitura da primeira transa��o.

-- Uma transa��o de Leitura, cria um bloqueio compartilhado e n�o deixar alterar os valores no range. Deixando os valores do Range integro.

-- Sequencia para Teste
	-- Transa��o 1 => Cria um bloqueio compartilhado nos dois registro, e n�o libera at� quem um comando COMMIT\ROLBACK seja executado
	Begin Transaction
	Select * From Produto
	Where ID < =2

	-- Transa��o 2 => O Update n�o consegue alterar os registros que est�o no range do select da Trans���o 1, at� que seja executado COMMIT\ROLLBACK
	Begin Transaction
	Update Produto Set Valor = 40
	Where ID = 1	


-- Problemas de concorr�ncia:
	-- Dirty Read: N�o
	-- Non-repeatable Read: N�o
	-- Phantom Read: Sim




SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
-- Este � o n�vel mais restritivo e corresponde, como o nome indica, a serializar TODAS as transa��es que acessam aos mesmos recursos.
-- Como nenhuma transa��o pode efetuar qualquer tipo de opera��o de modifica��o sobre dados que estejam a ser lidos por transa��es ativas,
-- elimina os �phantom reads�. Note-se, no entanto que, por isso mesmo, tem um efeito muito negativo no n�vel de concorr�ncia do servidor.

-- Outras transa��es n�o podem inserir linhas novas com valores chave que estejam no intervalo de chaves lido por qualquer instru��o da transa��o atual at� que 
-- esta seja conclu�da.

-- Nivel mais Restritivo, Bloqueia at� o que n�o existe.

-- Sequencia para Teste
	-- Transa��o 1 => Retorna range de 3 registros (Valores 10,20 e 30)
	Begin Transaction
	Select * From Produto
	Where Valor <= 30
	
	-- Transa��o 2 => N�o consigo alterar o valor do Registro 4, Note que ele n�o faz parte do range do select da transa��o 1. Mas se o update for executado o registro 4 
    --				  ira entrar no range do select, e isso � bloqueado pelo nivel SERIALIZABLE
	Begin Transaction
	Update Produto Set Valor = 5
	Where ID = 4

-- Problemas de concorr�ncia:
	-- Dirty Read: N�o
	-- Non-repeatable Read: N�o
	-- Phantom Read: N�o