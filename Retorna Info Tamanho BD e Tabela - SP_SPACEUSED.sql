exec sp_spaceused -- -- retorna informa��es do Banco 

exec sp_spaceused 'Tabela' -- retorna informa��es da Tabea

/*
RESERVED: Espa�o total reservado pelo banco de dados �para armazenamento de dados�. Por mais que sejam exclu�dos registros do banco, 
		  ele nunca reduz o seu tamanho (a n�o ser que seja feito o Shrink Database, que ir� devolver ao disco o espa�o UNUSED do banco).

DATA: Quantidade em KB de dados no banco de dados

INDEX_SIZE: Tamanho utilizado somente para a indexa��o de valores. Muitos �ndices em um banco podem elevar consideravelmente 
			o tamanho do banco, � necess�rio estar atento. 

UNUSED: Espa�o que foi alocado ao banco de dados, por�m n�o est� sendo utilizado. Este espa�o pode ser retomado ao disco atrav�s 
		da ferramenta Shrink Database
*/