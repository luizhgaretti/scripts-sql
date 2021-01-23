-- Muda o contexto do banco de dados
USE Master

-- Cria um banco de dados chamado BDSSD (SQL Server Day)
CREATE DATABASE BDSSD ON (
	NAME='BDSSD_Data',
	FILENAME='C:\SSD\BDSSD_Data.MDF')
LOG ON (
	NAME='BDSSD_Log',
	FILENAME='C:\SSD\BDSSD_Log.LDF')
