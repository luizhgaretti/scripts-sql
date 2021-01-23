--Declarando um variável @HashThis--
DECLARE @MeuValorCriptografado NVarChar(max);

SELECT @MeuValorCriptografado = CONVERT(nvarchar,'Pedro');

/* Utilizando a função HashBytes para converter a sentença 
com uso do Algoritmo Hash + SHA1*/
SELECT HashBytes('SHA1', @MeuValorCriptografado);
GO
