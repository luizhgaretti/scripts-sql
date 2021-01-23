-- Retorna os dados em Caixa Alta
Select UPPER(ProdNome) From Produto

-- Retorna os dados em Caixa Baixa
Select LOWER(ProdNome) From Produto

-- Retorna a Quantidade de Caracteres
Select LEN(ProdNome) Qtde, ProdNome From Produto

-- Retorna o conte�do do lado esquerdo do texto a partir da posi��o passada na fun��o
Select LEFT(ProdNome, 2), ProdNome From Produto

-- Retorna o conte�do do lado direito do texto a partir da posi��o passada na fun��o
Select Right(ProdNome, 2), ProdNome From Produto


-- Substitui o string pelo o par�metro desejado
SELECT REPLACE('O rato roeu a roupa do rei de roma', 'roupa', 'camisa')


-- Retorna uma parte do string passado como par�metro, utilizando o string,
-- O caracter inicial e o numero de caracteres que devem ser retornados.
SELECT SUBSTRING('O rato roeu a roupa do rei de roma', 8, 4)