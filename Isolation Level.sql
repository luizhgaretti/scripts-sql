SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- Permite fazer Select em um registro, mesmo que esse registro esteja com transação aberta(Update, Delete)

-- Otimista

-- Como se existisse NOLOCK em todas as consultas

-- Sequencia para Teste
	-- Transação 1 => Update ID 1 (Sucesso)
	-- Transação 2 => Select ID 1 (Sucesso) -> Le o dado sujo, pois ainda não executado COMMIT ou ROLLBACK na Transação 1

-- Problemas de concorrência:
	-- Dirty Read: SIM
	-- Non-repeatable Read: SIM
	-- Phantom Read: SIM



SET TRANSACTION ISOLATION LEVEL READ COMMITTED
 -- Default do SQL Server

 -- Nenhuma transação conseguirá obter um shared lock (de leitura) sobre recursos que tenham sido alterados (exclusive lock) por transações ainda não terminadas.

 -- Le o Registro e Libera o bloqueio.

-- Sequencia para Teste
	-- Transação 1 => Sucesso, como ainda não foi executado COMMIT\ROLLBACK a transação continuar com bloqueio de Alteração (X) sobre o registro
			Begin Transaction
				Update Produto Set Valor = 40
				Where ID = 2	

	-- Transação 2 => Transação fica em espera, pois a Transação 1 está com bloqueio de alteração (X) sobre esse Registro
		Begin Transaction
		Select * From Produto
		Where ID = 2

-- Problemas de concorrência:
	-- Dirty Read: NÃO
	-- Non-repeatable Read: SIM
	-- Phantom Read: SIM




SET TRANSACTION ISOLATION LEVEL SNAPSHOT
-- Este nível de isolamento ficaria entre o nível READ UNCOMMITED e READ COMMITED. 
-- Permite a uma transação, a leitura de dados atualizados por uma segunda transação, porém trazendo os dados originais (não alterados ainda). 
-- O SQL utiliza-se de uma cópia temporária dos dados originais neste caso, para o banco TempDB. 
-- Para usar este nível de isolamento em um banco de dados, execute o comando SET ALLOW_SNAPSHOT_ISOLATION ON.
	-- Alter Database AdventureWorks2012 SET ALLOW_SNAPSHOT_ISOLATION ON

-- Pega Ultima versão Comitada, Busca no Tempo DB

-- Sequencia para Teste
	-- Transação 1> Mudou o valor de 20 para 40, mas ainda não deu commit, então por enquanto o ultimo valor commitado é 20
		Begin Transaction
		Update Produto Set Valor = 40
		Where ID = 2
	
	-- Transação 2	Retorna o ultimo valor commitado, no caso, 20(OBS: Mesmo com a Trans. aberta ele cosnegue fazer o select, porem, pegar o ultimo valor comitado)
		Begin Transaction
		Select * From Produto
		Where ID = 2



SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
-- Este modo é diferente do anterior porque os locks de leitura são mantidos até ao final da transação. Isto significa que nenhuma transação pode alterar um recurso 
-- que tenha sido lido por uma transação não terminada. Por isso impede “non-repeatable reads”. No entanto, os “phantom reads” não são impedidos porque a nova transação 
-- pode ainda inserir registros que afetem a leitura da primeira transação.

-- Uma transação de Leitura, cria um bloqueio compartilhado e não deixar alterar os valores no range. Deixando os valores do Range integro.

-- Sequencia para Teste
	-- Transação 1 => Cria um bloqueio compartilhado nos dois registro, e não libera até quem um comando COMMIT\ROLBACK seja executado
	Begin Transaction
	Select * From Produto
	Where ID < =2

	-- Transação 2 => O Update não consegue alterar os registros que estão no range do select da Transãção 1, até que seja executado COMMIT\ROLLBACK
	Begin Transaction
	Update Produto Set Valor = 40
	Where ID = 1	


-- Problemas de concorrência:
	-- Dirty Read: Não
	-- Non-repeatable Read: Não
	-- Phantom Read: Sim




SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
-- Este é o nível mais restritivo e corresponde, como o nome indica, a serializar TODAS as transações que acessam aos mesmos recursos.
-- Como nenhuma transação pode efetuar qualquer tipo de operação de modificação sobre dados que estejam a ser lidos por transações ativas,
-- elimina os “phantom reads”. Note-se, no entanto que, por isso mesmo, tem um efeito muito negativo no nível de concorrência do servidor.

-- Outras transações não podem inserir linhas novas com valores chave que estejam no intervalo de chaves lido por qualquer instrução da transação atual até que 
-- esta seja concluída.

-- Nivel mais Restritivo, Bloqueia até o que não existe.

-- Sequencia para Teste
	-- Transação 1 => Retorna range de 3 registros (Valores 10,20 e 30)
	Begin Transaction
	Select * From Produto
	Where Valor <= 30
	
	-- Transação 2 => Não consigo alterar o valor do Registro 4, Note que ele não faz parte do range do select da transação 1. Mas se o update for executado o registro 4 
    --				  ira entrar no range do select, e isso é bloqueado pelo nivel SERIALIZABLE
	Begin Transaction
	Update Produto Set Valor = 5
	Where ID = 4

-- Problemas de concorrência:
	-- Dirty Read: Não
	-- Non-repeatable Read: Não
	-- Phantom Read: Não