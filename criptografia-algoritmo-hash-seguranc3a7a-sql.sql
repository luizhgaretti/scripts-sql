--Declarando um vari�vel @HashThis--
DECLARE @MeuValorCriptografado NVarChar(max);

SELECT @MeuValorCriptografado = CONVERT(nvarchar,'Pedro');

/* Utilizando a fun��o HashBytes para converter a senten�a 
com uso do Algoritmo Hash + SHA1*/
SELECT HashBytes('SHA1', @MeuValorCriptografado);
GO
