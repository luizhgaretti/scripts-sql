/*
Data: 11-07-2011

Script:
Script para o Post:
http://leka.com.br/2011/07/11/corrompendo-um-banco-sql/

Esse script está sendo provido como está.
Qualquer alteração/reescrita ou execução em ambiente que não seja de teste é um problema
TOTALMENTE seu.

Autor: Ricardo Leka Roveri
email: ricardo@leka.com.br
site: http://leka.com.br
twitter: @bigleka
*/

-- Cria a base Corrompeu
CREATE DATABASE [corrompeu]
 ON  PRIMARY 
( NAME = N'corrompeu', FILENAME = N'D:\DB01\local\corrompeu.mdf' , SIZE = 4096KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'corrompeu_log', FILENAME = N'D:\DB01\local\corrompeu_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO

-- altera o modo de recovery para FULL
alter database corrompeu
set recovery full
GO


use corrompeu
GO

-- Cria a tabela Vendas
create table vendas
(
vendasID int identity,
clienteID int default convert(int, 100000 * RAND()),
vendaData datetime default getdate(),
vendaTotal money
)
GO
create clustered index vendaCI on vendas (vendasID)
GO

set nocount ON
GO
-- Gera alguns dados dentro da tabela
declare @conta INT
select @conta = 0
while (@conta < 50000)
begin
	insert into vendas (vendaTotal)
	values (100*RAND())
	select @conta = @conta +1
end
GO

use master
GO
-- Executa um backup FULL
backup database corrompeu
to disk = 'd:\db01\local\corrompeu_1.bak'
with init
go

-- executa um backup de Transaction Log
backup log corrompeu
to disk = 'd:\db01\local\corrompeu_2.trn'
go

use master
go
-- Localize a página que você quer "corromper"
dbcc ind ('corrompeu','vendas',1)
GO

DBCC TRACEON (3604)
GO
-- Aqui você consegue ver o conteúdo da página, 
-- para poder ter certeza que está corrompendo uma página com dados
-- troca o XXX pelo número da página que você quer corromper 
dbcc page('corrompeu',1,XXX,3)
--vendasID de XXXXX até XXXXX

alter database corrompeu
set offline
GO

-- Troca o XXX pelo número da página que você quer corromper
select XXX*8192
GO

/*

Nesta parte você vai utilizar as instruções do Post 
para editar o banco no editor Hexadecimal

*/


alter database corrompeu
set online
GO

use corrompeu
go

-- Você vai receber a mensagem de erro na leitura da página corrompida
select * from vendas
GO

use master
GO
-- verifica o que está ocorrendo com o banco
dbcc checkdb('corrompeu')
with all_errormsgs, no_infomsgs
GO

DBCC TRACEON (3604)
GO
-- tenta ler a página
dbcc page('corrompeu',1,493,3)
GO

-- tenta ler a página
dbcc page('corrompeu',1,493,2)
GO

alter database corrompeu
set single_user
GO

-- verifica se existe alguma outra página corrompida
select * from msdb..suspect_pages
GO

-- backup do TAIL LOG, MUITO IMPORTANTE, o SQL não vai deixar continuar a manutenção sem ele.
backup log corrompeu
to disk = 'd:\db01\local\corrompeu_3_TAIL.trn'
with init
GO

-- aqui ele vai iniciar a manutenção na base e vai remover a página com problema
-- todos os registros dentro desta página serão perdidos
dbcc checkdb('corrompeu', repair_allow_data_loss)
with no_infomsgs
GO

-- Vamos comerçar a recuperar o banco
restore database corrompeu
PAGE = '1:XXX' -- Coloca aqui a página que você corrompeu
from disk = 'd:\db01\local\corrompeu_1.bak'
with norecovery
go

restore log corrompeu
from disk = 'd:\db01\local\corrompeu_2.trn'
with norecovery
GO

restore log corrompeu
from disk = 'd:\db01\local\corrompeu_3_TAIL.trn'
with norecovery
GO

restore database corrompeu
with recovery
GO

-- valida se a base está operacional
dbcc checkdb('corrompeu')
with all_errormsgs, no_infomsgs

alter database corrompeu
set multi_user
GO

use corrompeu
go


select * from vendas
GO


-- Se a página de dados foi excluida e você ainda não iniciou o processo de restore
-- Você pode ver qual a janela de dados que está faltando...
select min(vendasid + 1) 
from vendas as A
where not exists (
select vendasid from vendas as B
where B.vendasid = A.vendasid + 1
)
GO
select max(vendasid - 1) 
from vendas as A
where not exists (
select vendasid from vendas as B
where B.vendasid = A.vendasid - 1
)
GO

use master
drop database corrompeu