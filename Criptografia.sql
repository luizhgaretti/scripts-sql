/*
***************************************************************************************************
	Criptogrando uma Variavel, Texto de forma Simple e com Senha, onde a senha � necessaria para
	descriptografar o conteudo
***************************************************************************************************
*/

-- Crip�tografia Simples
Declare @Hash varchar(100)

Select @Hash = 'Encrypedt Text'
Select HashBytes('MD5', @Hash)
Select @Hash = 'Encrypedt Text'
Select HashBytes('SHA', @Hash)





-- Crip�tografia com Senha
Declare @Encryp  varbinary(80)
Select @Encryp = ENCRYPTBYPASSPHRASE('6141', 'Encrypted Text')
Select @Encryp, CAST(DECRYPTBYPASSPHRASE('6141', @Encryp) as varchar(max)) as Descripografia