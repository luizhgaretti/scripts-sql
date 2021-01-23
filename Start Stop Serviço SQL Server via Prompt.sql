--===============================================
--= Iniciando e Parando o Serviço do SQL Server =
--= Luiz Henrique								=
--= Data: 02/10/2012							=
--===============================================

--Parando e Iniciando o Serviço do SQL Server via PROMPT:
-> NET STOP MSSQLSERVER
-> NET START MSSQLSERVER

--Para Instancias nomeadas
NET STOP MSSQL$ServidorSQL2008
NET START MSSQL$NomedaInstancia