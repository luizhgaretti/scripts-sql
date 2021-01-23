CREATE DATABASE AdventureWorks_SBSExample1 ON 
( NAME = AdventureWorks_Data, 
  FILENAME = 'C:\MySnapshotData\AdventureWorks_SBSExample1.snapshot') 
AS SNAPSHOT OF AdventureWorks;
GO
