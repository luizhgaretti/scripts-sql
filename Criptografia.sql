/*
***************************************************************************************************
	Criptogrando uma Variavel, Texto de forma Simple e com Senha, onde a senha é necessaria para
	descriptografar o conteudo
***************************************************************************************************
*/

-- Cripítografia Simples
Declare @Hash varchar(100)

Select @Hash = 'Encrypedt Text'
Select HashBytes('MD5', @Hash)
Select @Hash = 'Encrypedt Text'
Select HashBytes('SHA', @Hash)





-- Cripítografia com Senha
Declare @Encryp  varbinary(80)
Select @Encryp = ENCRYPTBYPASSPHRASE('6141', 'Encrypted Text')
Select @Encryp, CAST(DECRYPTBYPASSPHRASE('6141', @Encryp) as varchar(max)) as Descripografia