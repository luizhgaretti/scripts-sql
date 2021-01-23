-- Muda o Contexto de Banco de Dados
USE Master

-- Cria o banco de dados
CREATE DATABASE BDSSD ON (
	NAME='BDSSD_Data',
	FILENAME='C:\SSD\BDSSD_Data.MDF')
LOG ON (
	NAME='BDSSD_Log',
	FILENAME='C:\SSD\BDSSD_Log.LDF')

-- Muda o Contexo de Banco de Dados
USE BDSSD

-- Muda o Owner da base
EXEC sp_changedbowner @loginame = 'sa'