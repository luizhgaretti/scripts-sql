IF OBJECT_ID('st_HexaToDBCCPAGE') IS NOT NULL
BEGIN
  DROP PROCEDURE st_HexaToDBCCPAGE
END
GO
CREATE PROCEDURE dbo.st_HexaToDBCCPAGE (@Hexa           VarBinary(50), 
                                        @DBID_File_Page VarChar(50) OUTPUT)
AS
/*
Revised by: Fabiano Neves Amorim
E-Mail: fabiano_amorim@bol.com.br
http://fabianosqlserver.spaces.live.com/
http://www.simple-talk.com/author/fabiano-amorim/

Use:
DECLARE @i VarChar(200)
exec dbo.st_HexaToDBCCPAGE @Hexa = 0x593B04000100, 
                           @DBID_File_Page = @i OUT

SELECT @i

*/
BEGIN
  DECLARE @First_4        VarChar(4),
          @Middle_4       VarChar(4),
          @Last_4         VarChar(4),
          @DBID           VarChar(20),
          @File           VarBinary(20),
          @Page           VarBinary(20),
          @Hexa_Str       VarChar(50),
          @SQL            NVarChar(200)
          
  SET @Hexa_Str = sys.fn_varbintohexstr(@Hexa)

  SET @DBID = DB_ID()
  
  SET @First_4  = SubString(@Hexa_Str, 3, 4)
  SET @Middle_4 = SubString(@Hexa_Str, 7, 4)
  SET @Last_4   = SubString(@Hexa_Str, 11, 4)
  
  SET @First_4  = SubString(@First_4, 3, 2)  + SubString(@First_4, 1, 2)
  SET @Middle_4 = SubString(@Middle_4, 3, 2) + SubString(@Middle_4, 1, 2)
  SET @Last_4   = SubString(@Last_4, 3, 2)   + SubString(@Last_4, 1, 2)

  SET @sql = 'SELECT @V_Page = ' + '0x' + @Middle_4 + @First_4 + ',' + 
                    '@V_File = ' + '0x' + @Last_4;

  EXEC sp_ExecuteSQL @stmt   = @sql,
                     @params = N'@V_Page AS VarBinary(50) OUTPUT, @V_File AS VarBinary(50) OUTPUT',
                     @V_Page = @Page OUTPUT,
                     @V_File = @File OUTPUT;

  SET @DBID_File_Page = 'DBCC PAGE (' + @DBID + ',' + CONVERT(VarChar, CONVERT(Int, @File)) + ',' + CONVERT(VarChar, CONVERT(Int, @Page)) + ',3)'
  
  RETURN
END
GO