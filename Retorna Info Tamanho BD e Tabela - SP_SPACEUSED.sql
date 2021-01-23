exec sp_spaceused -- -- retorna informações do Banco 

exec sp_spaceused 'Tabela' -- retorna informações da Tabea

/*
RESERVED: Espaço total reservado pelo banco de dados “para armazenamento de dados”. Por mais que sejam excluídos registros do banco, 
		  ele nunca reduz o seu tamanho (a não ser que seja feito o Shrink Database, que irá devolver ao disco o espaço UNUSED do banco).

DATA: Quantidade em KB de dados no banco de dados

INDEX_SIZE: Tamanho utilizado somente para a indexação de valores. Muitos índices em um banco podem elevar consideravelmente 
			o tamanho do banco, é necessário estar atento. 

UNUSED: Espaço que foi alocado ao banco de dados, porém não está sendo utilizado. Este espaço pode ser retomado ao disco através 
		da ferramenta Shrink Database
*/